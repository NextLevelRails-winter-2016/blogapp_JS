FactoryGirl.define do
  factory :post do
  	association :user
    title "MyString"
    article "MyString"
  end

  factory :election, class: Post do
    association :user
    title "Trump"
    article "how can this be possible?"
  end

  factory :thanksgiving, class: Post do
    association :user
    title "thanksgiving"
    article "cannot wait to eat turkey"
  end

  factory :invalid_post, class: Post do
    title nil
    article nil
  end
end
