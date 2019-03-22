class UserMailer < ApplicationMailer
  default from: "Photo Forum <info@cc.com>"

  def send_promote_code(user)
    @user = user
    @content = "Here is your code: " + rand(2..99999).to_s + "<br> Thank you!"
    mail to: user.email,
 
    subject: "promote code TOP 100"
  end
end
