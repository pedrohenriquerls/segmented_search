require 'spec_helper'

describe QuerySegment do

  it 'should save and get contacts' do
    sherlock = FactoryGirl.create(:sherlock)
    FactoryGirl.create(:moriarty)

    expect(Contact.count).to eq 2

    params = {
        state: '=\'United Kingdom\'',
        group: 'AND',
        age: '>50'
    }

    segment = QuerySegment.new
    segment.params=params
    segment.name = 'England people'

    expect(segment.save!).to be_truthy

    contacts = segment.contacts
    expect(contacts.count).to eq 1
    expect(contacts.first.name).to eq sherlock.name
  end

  describe '.params_to_query' do
    it 'should parse the hash to query' do
      params = {
          name: '=\'Sherlock Holmes\'',
          group: 'AND',
          age: '<40'
      }

      segment = QuerySegment.new
      segment.params=params
      expect(segment.params_to_query).to eq('name =\'Sherlock Holmes\' AND age <40')
    end

    it 'should parse the hash to query' do
      params = {
          name: '="Sherlock Holmes"',
          group: 'OR',
          state: '="SP"'
      }

      segment = QuerySegment.new
      segment.params=params
      expect(segment.params_to_query).to eq('name =\'Sherlock Holmes\' OR state ="SP"')
    end
  end
end