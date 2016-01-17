class Inquiry < ActiveRecord::Base

  #名前の制限
  #validates :name,presence: true
  validates :name, :presence => {:message => '名前を入力してください'}


  #Eメールの制限
  validates :email, :presence => {:message => 'メールアドレスを入力してください'}
  validates :email, :uniqueness => {:message => 'このメールアドレスは既に登録済みです'}
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { :with => VALID_EMAIL_REGEX , message: '正しいメールアドレスを入力してください'}

  #メッセージの制限
  validates :message, :presence => {:message => '名前を入力してください'}



end
