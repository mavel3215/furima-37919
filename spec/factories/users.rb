FactoryBot.define do
  factory :user do
    transient do
      person {Gimei.name}
    end

    nickname {Faker::Name.initials(number:2)}
    email    {Faker::Internet.free_email}
    password {Faker::Lorem.characters(number: 6, min_alpha: 3, min_numeric: 3)}
    password_confirmation {password}

    first_name {person.first}
    last_name  {person.last}
    first_name_katakana {person.first.katakana}
    last_name_katakana  {person.last.katakana}
    birthday  {Faker::Date.backward}

  end
end
