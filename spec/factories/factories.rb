FactoryGirl.define do

  factory :admin, class: User do
    name "Example User"
    email "example@railstutorial.org"
    password "foobar"
    password_confirmation "foobar"
    admin true
  end

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "example_#{n}@railstutorial.org" }
    password "foobar"
    password_confirmation "foobar"
    MyLog.debug "FactoryGirly:user Creating user #{user.ai}"
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end

