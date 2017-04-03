class ApplicationMailer < ActionMailer::Base
  default from: 'clauditcoder@gmail.com' # this is where the email will be sent from to user after any booking have been made. Basically is PairBnB email address.
  layout 'mailer'
end
