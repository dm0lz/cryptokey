json.extract! email, :id, :title, :body, :created_at, :updated_at
json.url email_url(email, format: :json)
