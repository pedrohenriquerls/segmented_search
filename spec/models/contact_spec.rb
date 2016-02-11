require 'spec_helper'

describe Contact do

  it 'should be invalid' do
    subject = FactoryGirl.build(:sherlock)
    subject.email = nil

    expect(subject.valid?).to be_falsey
  end

  it 'should be valid' do
    subject = FactoryGirl.build(:sherlock)
    expect(subject.valid?).to be_truthy
  end

end
