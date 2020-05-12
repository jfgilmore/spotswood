FactoryBot.define do
  # Define sequences
  sequence :name do
    "John Doe#{n}"
  end
  sequence :email do |n|
    "person#{n}@test.com"
  end

  # Define listings
  # factory :listing do
  #   name { 'I need help' }
  #   date { Time.now }
  #   why { 'I have no skills or abilities' }
  #   location { 'My house' }
  #   cost { 0 }
  #   summary { 'Some sob story blah blah fdnsl fdsklfdslf dsklf slkfds klfsdal fds lkfsdlflsd.' }
  #   description { 'To give back to the community' }

  #   trait :produce do
  #     category { :produce }
  #   end
  #   trait :fundraising do
  #     category { :fundraising }
  #   end
  #   trait :sharing do
  #     category { :sharing }
  #   end
  #   trait :caring do
  #     category { :caring }
  #   end
  # end

  # Define user
  factory :user do
    name
    email
    # Listings by user
    # factory :listing do
    #   listings_count {2}
    #   after(:create) do |user, evaluator|
    #     create_list(:listing, evaluator.listings_count, users: [user])
    #   end
    # end
  end
end