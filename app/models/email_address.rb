class EmailAddress < ActiveRecord::Base
  belongs_to :contact, polymorphic: true
  validates :address, :contact_id, :contact_type, presence: true
end
