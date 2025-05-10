class SentEmailsController < ApplicationController
  include EmailSearchable

  def index
    @inbox_emails = inbox_emails
    @sent_emails = sent_emails
  end
end
