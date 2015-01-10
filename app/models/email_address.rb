class EmailAddress < ActiveRecord::Base
  validates :address, :email_to_id, presence: true
  belongs_to :email_to, polymorphic: true
end
