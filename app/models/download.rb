class Download < ActiveRecord::Base
  MAXIMUM_TRIES = 5

  belongs_to :subscription
  belongs_to :guest_subscription
  belongs_to :theme
  belongs_to :user
end
