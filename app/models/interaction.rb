class Interaction < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  enum type: %i[chip_in help_out be_there mine sold]
end
