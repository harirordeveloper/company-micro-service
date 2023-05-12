class User < ApplicationRecord
  include EmployeeSync
  searchkick word_start: [:first_name, :last_name, :email]
  has_secure_password
  self.inheritance_column = :type
  belongs_to :company

  validates :email, presence: true, uniqueness: true
  before_validation :ensure_jti_is_set

  def revoke_jwt
    update_column(:jti, generate_jti)
  end

  def search_data
    {
      first_name: first_name,
      last_name: last_name,
      email: email
    }
  end

  private

    def generate_jti
      SecureRandom.uuid
    end

    def ensure_jti_is_set
      self.jti = generate_jti
    end
end