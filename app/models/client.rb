class Client < ActiveRecord::Base

  # Soft delete - uses deleted_at field
  acts_as_paranoid

  validates :contact_name, length: {minimum: 2, maximum: 30}, presence: true
  validates :contact_phone, length: {minimum: 8, maximum: 20}
  validates :email, length: {minimum: 6}, presence: true, uniqueness: true
  validates :name, length: {maximum: 50}, presence: true, uniqueness: true

  has_many :projects, inverse_of: :client

  def to_s
    name
  end

end
