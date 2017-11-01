class User < ApplicationRecord

  validates :username, :password_digest, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true

  after_initialize :ensure_session_token

  has_many :subs
  has_many :posts

  attr_reader :password

  def ensure_session_token
    self.session_token ||= reset_session_token
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64
    self.save
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    if @user && @user.is_password?(password)
      return @user
    end
    nil
  end


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end





end
