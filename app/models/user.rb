class User < ApplicationRecord
  has_many :comments, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_secure_password
  has_many :questions, dependent: :nullify
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".squeeze(" ").strip.titleize
  end

end
