require 'rails_helper'

describe 'the compay view', type: :feature do
  describe 'phone numbers' do
    let(:company) { Company.create(name: 'RuckFuckers') }

    before(:each) do
      company.phone_numbers.create(number: "555-1234")
      company.phone_numbers.create(number: "555-5683")
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number',href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')

    end

    it 'has links to edit a phone number' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_phone = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_phone)
    end

    it 'has a link to delete a phone number' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'delets a phone number' do
      phone = company.phone_numbers.first

      first(:link, 'delete').click
      expect(page).to_not have_content("555-1234")
    end
  end


  describe 'email addresses' do
    let(:company) { Company.create(name: 'ShittyWok') }

    before(:each) do
      company.email_addresses.create(address: "fuck@gmail.com")
      company.email_addresses.create(address: "bmrsny@gmail.com")
      visit company_path(company)
    end

    it 'shows email address' do
      company.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it 'has an email address link to new email adresses' do
      company.email_addresses.each do |email|
        expect(page).to have_link('new_email_address', href: new_email_address_path(email_to_id: company.id, email_to_type: 'Company'))
      end
    end

    it 'follows email creation workflow' do
      first(:link, 'new_email_address').click
      page.fill_in("Address", with: 'ShitWeAreHere@yahoo.com')
      page.click_button("Create Email address")
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('ShitWeAreHere@yahoo.com')
    end

    it 'has an email address link to edit emails' do
      company.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it 'follows email edit workflow' do
      email = company.email_addresses.first
      old_email = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'Shitz@gmail.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('Shitz@gmail.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has an email address link to delete emails' do
      company.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end

    it 'follows email delete workflow' do
      email = company.email_addresses.first

      first(:link, 'delete').click
      expect(current_path).to eq(company_path(company))
      expect(page).to_not have_content("Shitz@gmail.com")
    end
  end
end
