module EmailSearchable
  extend ActiveSupport::Concern

  def inbox_emails
    emails = Email.where(to_email: Current.user.email_address)

    if params[:q].present?
      query = "%#{params[:q].downcase}%"
      emails = emails.where(
        "LOWER(subject) LIKE ? OR LOWER(from_email) LIKE ? OR LOWER(to_email) LIKE ?",
        query, query, query
      )
    end

    emails.order(created_at: :desc)
  end

  def sent_emails
    Email.where(from_email: Current.user.email_address)
  end
end