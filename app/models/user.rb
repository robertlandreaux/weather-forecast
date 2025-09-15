class User < PrimaryApplicationRecord
  validates :full_name, :email, presence: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
end
