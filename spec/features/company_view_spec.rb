require 'rails_helper'

describe 'the company view', type: :feature do
  let(:company) { Company.create(name: "Shinra Corp") }

  describe "Phone number display" do
    before(:each) do
      company.phone_numbers.create(number: "555-1234")
      company.phone_numbers.create(number: "555-5678")
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add a phone number', href: new_phone_number_path(contact_id: company.id, contact_type: "Company"))
    end

    it 'adds a phone number' do
      page.click_link('Add a phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(PhoneNumber.count).to eq(3)
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it "has links to edit phone numbers" do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it "edits a phone number" do
      phone = company.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it "has links to delete phone numbers" do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it "deletes a phone number" do
      first("ul#phone-numbers a.delete-phone").click
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("555-5678")
      expect(page).to_not have_content("555-1234")
    end
  end

  describe "email addresses" do
    before do
      company.email_addresses.create(address: "work@example.com")
      company.email_addresses.create(address: "home@example.com")
      visit company_path(company)
    end

    it "shows the emails in a list" do
      company.email_addresses.each do |addr|
        expect(page).to have_selector('li span', text: addr.address)
      end
    end

    it 'has a link to add a new email' do
      expect(page).to have_link('Add an email', href: new_email_address_path(contact_id: company.id, contact_type: "Company"))
    end

    it 'adds an email' do
      page.click_link('Add an email address')
      page.fill_in('Address', with: 'pizzaman@pizza.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('pizzaman@pizza.com')
    end

    it "hides the company id field in the email form" do
      expect(page).to have_link('Add an email address', href: new_email_address_path(contact_id: company.id, contact_type: "Company"))
      page.click_link('Add an email address')
      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq(new_email_address_path(contact_id: company.id, contact_type: "Company"))
      expect(page).to have_selector("input#email_address_contact_id[type=hidden]")
    end

    it "has links to edit emails" do
      company.email_addresses.each do |addr|
        expect(page).to have_link('edit', href: edit_email_address_path(addr))
      end
    end

    it "edits an email" do
      email = company.email_addresses.first
      old_addr = email.address

      first("ul#emails a").click
      page.fill_in('Address', with: 'newemailforme@example.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('newemailforme@example.com')
      expect(page).to_not have_content(old_addr)
    end

    it "has links do delete emails" do
      company.email_addresses.each do |addr|
        expect(page).to have_link('delete', href: email_address_path(addr))
      end
    end

    it "deletes an email" do
      to_delete = company.email_addresses.first
      not_to_delete = company.email_addresses.last
      first("ul#emails a.delete-email").click
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content(not_to_delete.address)
      expect(page).to_not have_content(to_delete.address)
    end
  end
end
