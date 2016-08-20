require 'test_helper'

class DatabaseRewinder::DatabaseRewinderTest < ActiveSupport::TestCase
  setup do
    DatabaseRewinder.init
  end

  sub_test_case '.[]' do
    teardown do
      DatabaseRewinder.database_configuration = nil
    end
    sub_test_case 'for connecting to an arbitrary database' do
      test 'simply giving a connection name only' do
        DatabaseRewinder.database_configuration = {'aaa' => {'adapter' => 'sqlite3', 'database' => ':memory:'}}
        DatabaseRewinder['aaa']
        assert_equal ['aaa'], DatabaseRewinder.instance_variable_get(:'@cleaners').map {|c| c.connection_name}
      end

      test 'giving a connection name via Hash with :connection key' do
        DatabaseRewinder.database_configuration = {'bbb' => {'adapter' => 'sqlite3', 'database' => ':memory:'}}
        DatabaseRewinder[connection: 'bbb']
        assert_equal ['bbb'], DatabaseRewinder.instance_variable_get(:'@cleaners').map {|c| c.connection_name}
      end

      test 'the Cleaner compatible syntax' do
        DatabaseRewinder.database_configuration = {'ccc' => {'adapter' => 'sqlite3', 'database' => ':memory:'}}
        DatabaseRewinder[:aho, connection: 'ccc']
        assert_equal ['ccc'], DatabaseRewinder.instance_variable_get(:'@cleaners').map {|c| c.connection_name}
      end
    end

    test 'for connecting to multiple databases' do
      DatabaseRewinder[:active_record, connection: 'test']
      DatabaseRewinder[:active_record, connection: 'test2']

      Foo.create! name: 'foo1'
      Quu.create! name: 'quu1'

      DatabaseRewinder.clean

      # it should clean all configured databases
      assert_equal 0, Foo.count
      assert_equal 0, Quu.count
    end
  end

  sub_test_case '.record_inserted_table' do
    def perform_insert(sql)
      DatabaseRewinder.database_configuration = {'foo' => {'adapter' => 'sqlite3', 'database' => 'test_record_inserted_table.sqlite3'}}
      @cleaner = DatabaseRewinder.create_cleaner 'foo'

      connection = ::ActiveRecord::Base.sqlite3_connection(adapter: "sqlite3", database: File.expand_path('test_record_inserted_table.sqlite3', Rails.root))
      DatabaseRewinder.record_inserted_table(connection, sql)
    end
    teardown do
      DatabaseRewinder.database_configuration = nil
    end

    sub_test_case 'common database' do
      test 'include database name' do
        perform_insert 'INSERT INTO "database"."foos" ("name") VALUES (?)'
        assert_equal ['foos'], @cleaner.inserted_tables
      end
      test 'only table name' do
        perform_insert 'INSERT INTO "foos" ("name") VALUES (?)'
        assert_equal ['foos'], @cleaner.inserted_tables
      end
      test 'without "INTO"' do
        perform_insert 'INSERT "foos" ("name") VALUES (?)'
        assert_equal ['foos'], @cleaner.inserted_tables
      end
    end

    sub_test_case 'Database accepts more than one dots in an object notation (e.g. SQLServer)' do
      test 'full joined' do
        perform_insert 'INSERT INTO server.database.schema.foos ("name") VALUES (?)'
        assert_equal ['foos'], @cleaner.inserted_tables
      end
      test 'missing one' do
        perform_insert 'INSERT INTO database..foos ("name") VALUES (?)'
        assert_equal ['foos'], @cleaner.inserted_tables
      end

      test 'missing two' do
        perform_insert 'INSERT INTO server...foos ("name") VALUES (?)'
        assert_equal ['foos'], @cleaner.inserted_tables
      end
    end

    test 'when database accepts INSERT IGNORE INTO statement' do
      perform_insert "INSERT IGNORE INTO `foos` (`name`) VALUES ('alice'), ('bob') ON DUPLICATE KEY UPDATE `foos`.`updated_at`=VALUES(`updated_at`)"
      assert_equal ['foos'], @cleaner.inserted_tables
    end
  end

  test '.clean' do
    Foo.create! name: 'foo1'
    Bar.create! name: 'bar1'
    DatabaseRewinder.clean

    assert_equal 0, Foo.count
    assert_equal 0, Bar.count
  end

  if ActiveRecord::VERSION::STRING >= '4'
    test '.clean_all should not touch AR::SchemaMigration' do
      begin
        ActiveRecord::SchemaMigration.create_table
        ActiveRecord::SchemaMigration.create! version: '001'
        Foo.create! name: 'foo1'
        DatabaseRewinder.clean_all

        assert_equal 0, Foo.count
        assert_equal 1, ActiveRecord::SchemaMigration.count

      ensure
        ActiveRecord::SchemaMigration.drop_table
      end
    end
  end

  sub_test_case '.clean_with' do
    def perform_clean(options)
      @cleaner = DatabaseRewinder.cleaners.first
      @only = @cleaner.instance_variable_get(:@only)
      @except = @cleaner.instance_variable_get(:@except)
      Foo.create! name: 'foo1'
      Bar.create! name: 'bar1'
      DatabaseRewinder.clean_with :truncation, options
    end

    test 'with only option' do
      perform_clean only: ['foos']
      assert_equal 0, Foo.count
      assert_equal 1, Bar.count
      assert_equal @only, @cleaner.instance_variable_get(:@only)
    end

    test 'with except option' do
      perform_clean except: ['bars']
      assert_equal 0, Foo.count
      assert_equal 1, Bar.count
      assert_equal @except, @cleaner.instance_variable_get(:@except)
    end
  end

  sub_test_case '.cleaning' do
    test 'without exception' do
      DatabaseRewinder.cleaning do
        Foo.create! name: 'foo1'
      end

      assert_equal 0, Foo.count
    end

    test 'with exception' do
      assert_raises do
        DatabaseRewinder.cleaning do
          Foo.create! name: 'foo1'; fail
        end
      end
      assert_equal 0, Foo.count
    end
  end

  sub_test_case '.strategy=' do
    sub_test_case 'call first with options' do
      setup do
        DatabaseRewinder.strategy = :truncate, { only: ['foos'], except: ['bars'] }
      end

      test 'should set options' do
        assert_equal ['foos'], DatabaseRewinder.instance_variable_get(:@only)
        assert_equal ['bars'], DatabaseRewinder.instance_variable_get(:@except)
      end

      test 'should create cleaner with options' do
        cleaner = DatabaseRewinder.instance_variable_get(:@cleaners).first
        assert_equal ['foos'], cleaner.instance_variable_get(:@only)
        assert_equal ['bars'], cleaner.instance_variable_get(:@except)
      end

      sub_test_case 'call again with different options' do
        setup do
          DatabaseRewinder.strategy = :truncate, { only: ['bazs'], except: [] }
        end

        test 'should overwrite options' do
          assert_equal ['bazs'], DatabaseRewinder.instance_variable_get(:@only)
          assert_equal [], DatabaseRewinder.instance_variable_get(:@except)
        end

        test 'should overwrite cleaner with new options' do
          cleaner = DatabaseRewinder.instance_variable_get(:@cleaners).first
          assert_equal ['bazs'], cleaner.instance_variable_get(:@only)
          assert_equal [], cleaner.instance_variable_get(:@except)
        end
      end
    end
  end
end
