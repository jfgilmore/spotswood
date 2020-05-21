class Interaction < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  enum user_action: { chip_in: 1, help_out: 2, be_there: 3, buy: 4 }
end
