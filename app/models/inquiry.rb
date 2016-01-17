class Inquiry < ActiveRecord::Base

  #名前の制限
  validates :name,presence: true

  #Eメールの制限
  validates :email,presence: true
  validates :email, uniqueness: true
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }

  #メッセージの制限
  validates :message,presence: true



end
