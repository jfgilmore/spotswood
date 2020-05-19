class Interaction < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  enum user_action: %i[chip_in help_out be_there buy]
end
