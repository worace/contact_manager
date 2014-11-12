require 'rails_helper'

RSpec.describe Company, :type => :model do
  let(:company) { Company.new(name: "WoracesWorkshop") }

  it "is valid" do
    assert company.valid?
  end

  it "is not valid without name" do
    company.name = nil
    refute company.valid?
  end

  it "has an array of phone numbers" do
    expect(company.phone_numbers).to eq([])
  end

  it "responds with its phone numbers after they're created" do
    phone_number = company.phone_numbers.build(number: "333-4444")
    expect(phone_number.number).to eq('333-4444')
  end
end
