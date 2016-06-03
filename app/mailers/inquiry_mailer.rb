class InquiryMailer < ActionMailer::Base
  default from: "from@example.com"
  default to: "ikebright@gmail.com"
  layout 'mailer'

  def received_email(inquiry)
    @inquiry = inquiry
#    binding.pry
   mail to: @inquiry.email, subject: '【Achieve】'+@inquiry.subject
  end

end
