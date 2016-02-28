class User < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :blogs, dependent: :destroy

  def password_required?
    if provider?
      false
    end
  end

  def email_required?
    false
  #  (authentications.empty? || !email.blank?) && super
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)

    user = User.where(provider: auth.provider, uid: auth.uid).first

    if user.blank?
      user = User.new(name:     auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         #email:    auth.info.email,
                         email:    User.create_unique_email,
                         #password: Devise.friendly_token[0,20],
                        )
      user.img_path = "https://graph.facebook.com/#{user.uid}/picture?width=48&height=48"
      user.skip_confirmation!
      user.save
#     elsif user.email != auth.info.email

#     logger.debug"--------------------------------------------"
#     logger.debug(user.email)
#     logger.debug(auth.info.email)
#     logger.debug"--------------------------------------------"
#             user.email = auth.info.email
#             user.skip_confirmation!
#       user.save
    end
    user

end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)

    user = User.where(provider: auth.provider, uid: auth.uid).first

    unless user
      user = User.new(name:     auth.info.nickname,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    User.create_unique_email,
                         #password: Devise.friendly_token[0,20],
                        )
      user.img_path = "http://furyu.nazo.cc/twicon/#{user.name}"
      user.skip_confirmation!
      user.save
    end
    user

  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end

end
