require 'spec_helper'

describe QuerySegment do

  it 'should save and get contacts' do
    sherlock = FactoryGirl.create(:sherlock)
    FactoryGirl.create(:moriarty)

    expect(Contact.count).to eq 2

    criteria = {
        state: {operator: '=', value:'United Kingdom', group: 'AND'},
        age: {operator:'>', value: 50}
    }.to_json

    segment = QuerySegment.new
    segment.criteria=criteria
    segment.name = 'England people'

    expect(segment.save!).to be_truthy

    contacts = segment.contacts
    expect(contacts.count).to eq 1
    expect(contacts.first.name).to eq sherlock.name
  end

  it 'avoid the possible sql injection' do
    criteria = {
        state: {operator: '=', value:'United Kingdom;DROP TABLE contacts;', group: 'AND'},
        age: {operator: '>', value: 50}
    }.to_json

    segment = QuerySegment.new
    segment.criteria=criteria
    segment.name = 'England people'

    expect(segment.save).to be_falsey
    segment.errors.messages[:criteria].should include(I18n.t('query_segment.invalid_words'))
  end

  describe '.criteria_to_query' do
    it 'should parse the hash to query' do
      criteria = {
          name: {operator: '=', value:'Sherlock Holmes', group: 'AND'},
          age: {operator: '<', value: '40'}
      }.to_json

      segment = QuerySegment.new
      segment.criteria=criteria
      expect(segment.criteria_to_query).to eq('name = \'Sherlock Holmes\' AND age < 40')
    end

    it 'should parse the hash to query' do
      criteria = {
          name: {operator: '=', value: 'Sherlock Holmes', group: 'OR'},
          state: {operator: '=', value: 'SP'}
      }.to_json

      segment = QuerySegment.new
      segment.criteria=criteria
      expect(segment.criteria_to_query).to eq('name = \'Sherlock Holmes\' OR state = \'SP\'')
    end
  end
end