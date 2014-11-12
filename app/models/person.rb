class Person < ActiveRecord::Base
  include Contact
  validates :first_name, :last_name, presence: true
end
