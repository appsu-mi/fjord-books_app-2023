# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Devise@example.com'
  layout 'mailer'
end
