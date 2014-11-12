require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:email) { EmailAddress.new(:address => "hi@pizza.com", :contact_id => 1, :contact_type => "Person") }

  it "is valid with an address" do
    email.address = "hi@example.com"
    assert email.valid?
  end

  it "is invalid without address" do
    email.address = nil
    refute email.valid?
  end

  it "is invalid without contact id" do
    email.contact_id = nil
    refute email.valid?
  end
end
