class Project < ActiveRecord::Base

  # Soft delete - uses deleted_at field
  acts_as_paranoid

  belongs_to :client, inverse_of: :projects

  validates :client, presence: true
  validates :name, length: {maximum: 100}, presence: true, uniqueness: {scope: :client_id}

  def to_s
    name
  end

end
