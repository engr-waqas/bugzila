# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'mohammad.waqas@devsinc.com'
  layout 'mailer'
end
