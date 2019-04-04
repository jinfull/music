# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :email, :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, allow_nil: true, length: { minimum: 6 }

    after_initialize :ensure_session_token

    attr_reader :password

    def self.generate_session_token
        SecureRandom::safeurl_base64
    end

    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)
    
        if @user && is_password?(password)
            return @user
        end

        nil
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        Bcrypt::Password.new(self.password_digest).is_password?(password)
    end
end
