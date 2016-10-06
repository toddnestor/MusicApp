class User < ApplicationRecord
  validates :email, :session_token, :password_digest, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  attr_reader :password

  after_create :send_activation_email

  after_initialize :ensure_session_token

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    return user if user && user.is_password?(password)
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom::urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def activate!
    self.activated = true
    self.save
  end

  private
  def send_activation_email
    self.activation_token = SecureRandom::urlsafe_base64
    self.save
    email = UserMailer.activation_email(self)
    email.deliver
  end
end
