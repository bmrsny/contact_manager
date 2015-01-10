require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:person) {Person.create(:first_name => "Jimmy", last_name: "Bob" )}
  let(:email_address) do
    EmailAddress.new(address: 'geoff@geoff.com', email_to_id: 1, email_to_type: 'Person')
  end

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is invalid without an address' do
    email_address.address = nil
    expect(email_address).to_not be_valid
  end

  it 'must have a reference to a person' do
    email_address.email_to_id = nil
    expect(email_address).not_to be_valid
  end

  it 'is associated with a email_to polymorphic relationship' do
    expect(email_address).to respond_to(:email_to)
  end
end
