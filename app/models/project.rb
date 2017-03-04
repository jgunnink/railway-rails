class Project < ActiveRecord::Base

  # Soft delete - uses deleted_at field
  acts_as_paranoid

  belongs_to :client, inverse_of: :projects

  validates :client, presence: true
  validates :name, length: {maximum: 100}, presence: true, uniqueness: {scope: :client_id}
  validates :stage, presence: true, 
  					numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  def to_s
    name
  end

end
