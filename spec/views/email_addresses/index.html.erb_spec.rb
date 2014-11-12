require 'rails_helper'

RSpec.describe "email_addresses/index", :type => :view do
  before(:each) do
    assign(:email_addresses, [
      EmailAddress.create!(
        :person_id => 1,
        :address => "Address"
      ),
      EmailAddress.create!(
        :person_id => 1,
        :address => "Address"
      )
    ])
  end

  it "renders a list of email_addresses" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
  end
end
