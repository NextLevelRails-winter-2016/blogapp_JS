FactoryGirl.define do
  factory :user do
    username "MyString"
    email "MyString"

    factory :user_with_posts do
      after(:build) do |user|
      	[:election, :thanksgiving].each do |post|
          user.posts << FactoryGirl.build(:election, user: user)
        end
      end
    end
  end
end
