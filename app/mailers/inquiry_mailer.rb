class InquiryMailer < ActionMailer::Base
  default from: "achieve@example.com"
  default to: "ikebright@gmail.com"
  layout 'mailer'

  def received_email(inquiry)
    @inquiry = inquiry
#    binding.pry
   mail to: @inquiry.email, subject: 'お問い合わせを承りました'
  end

end
