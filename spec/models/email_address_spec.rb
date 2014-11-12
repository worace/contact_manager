require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:email) { EmailAddress.new(:address => "hi@pizza.com", :person_id => 1) }

  it "is valid with an address" do
    email.address = "hi@example.com"
    assert email.valid?
  end

  it "is invalid without address" do
    email.address = nil
    refute email.valid?
  end

  it "is invalid without person id" do
    email.person_id = nil
    refute email.valid?
  end
end
