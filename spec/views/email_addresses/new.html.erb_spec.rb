require 'rails_helper'

RSpec.describe "email_addresses/new", :type => :view do
  before(:each) do
    assign(:email_address, EmailAddress.new(
      :person_id => 1,
      :address => "MyString"
    ))
  end

  it "renders new email_address form" do
    render

    assert_select "form[action=?][method=?]", email_addresses_path, "post" do

      assert_select "input#email_address_person_id[name=?]", "email_address[person_id]"

      assert_select "input#email_address_address[name=?]", "email_address[address]"
    end
  end
end
