FactoryGirl.define do
  factory :user do
    firstname {FFaker::Name.first_name}
    lastname {FFaker::Name.last_name}
    email {FFaker::Internet.email}
    password 'Password1'
    encrypted_password 'Password1'

    factory :user_with_posts do
      after(:build) do |user|
        [:election, :thanksgiving].each do |post|
          user.posts << FactoryGirl.create(post, user: user)
        end
      end
    end
  end
end
