class Company < ActiveRecord::Base
  include Contact
  validates :name, presence: true
end
