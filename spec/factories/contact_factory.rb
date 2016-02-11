
FactoryGirl.define do
  factory :sherlock, class: 'Contact' do
    name 'Sherlock Holmes'
    email 'sherlock@gmail.com'
    state 'United Kingdom'
    role 'Private Detective'
    age 57
  end

  factory :moriarty, class: 'Contact' do
    name 'Moriarty'
    email 'moriarty@gmail.com'
    state 'United Kingdom'
    role 'Professor'
    age 47
  end

  factory :soares, class: 'Contact' do
    name 'Jô Soares'
    email 'jo@gmail.com'
    state 'Rio de Janeiro'
    role 'Apresentador'
    age 23
  end
end