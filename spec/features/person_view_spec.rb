require 'rails_helper'

describe 'the person view', type: :feature do
  describe 'phone numbers' do
    let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

    before(:each) do
      person.phone_numbers.create(number: "555-1234")
      person.phone_numbers.create(number: "555-5683")
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number',href: new_phone_number_path(person_id: person.id))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')

    end

    it 'has links to edit a phone number' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_phone = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_phone)
    end

    it 'has a link to delete a phone number' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'delets a phone number' do
      phone = person.phone_numbers.first

      first(:link, 'delete').click
      expect(page).to_not have_content("555-1234")
    end
  end


  describe 'email addresses' do
    let(:person) { Person.create(first_name: 'Brandon', last_name: 'Mrsny') }

    before(:each) do
      person.email_addresses.create(address: "fuck@gmail.com")
      person.email_addresses.create(address: "bmrsny@gmail.com")
      visit person_path(person)
    end

    it 'shows email address' do
      person.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it 'has an email address link to new email adresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('new_email_address', href: new_email_address_path(person_id: person.id))
      end
    end

    it 'follows email creation workflow' do
      first(:link, 'new_email_address').click
      page.fill_in("Address", with: 'ShitWeAreHere@yahoo.com')
      page.click_button("Create Email address")
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('ShitWeAreHere@yahoo.com')
    end

    it 'has an email address link to edit emails' do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it 'follows email edit workflow' do
      email = person.email_addresses.first
      old_email = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'Shitz@gmail.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('Shitz@gmail.com')
      expect(page).to_not have_content(old_email)
    end

    it 'has an email address link to delete emails' do
      person.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end

    it 'follows email delete workflow' do
      email = person.email_addresses.first

      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content("Shitz@gmail.com")
    end
  end
end
