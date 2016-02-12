
FactoryGirl.define do
  factory :sherlock_without_jo, class: 'QuerySegment' do
    name 'sherlock'
    criteria "{'name': {'operator': '=', 'value': 'Sherlock Holmes', 'group': 'or'}, 'age': {'operator': '>', 'value': 30}}"
  end
end