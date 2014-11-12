require 'rails_helper'

RSpec.describe "email_addresses/show", :type => :view do
  before(:each) do
    @email_address = assign(:email_address, EmailAddress.create!(
      :person_id => 1,
      :address => "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Address/)
  end
end
