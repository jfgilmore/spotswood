require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:user) { User.new }
  subject do
    described_class.new(
      name: "Tiny Tim's fundraiser", summary: 'Tims needs help, he has a rare
      genetic disease that makes it so he can not use appostrophes',
      at_time: (Time.now + 24 * 60 * 60), location: 'My house', user: user
    )
  end

  # Validations
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'is not vailid with a name longer than 40 characters' do
    subject.name = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmno'
    expect(subject).to_not be_valid
  end

  it 'is not valid without a summary' do
    subject.summary = ''
    expect(subject).to_not be_valid
    subject.summary = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a location' do
    subject.location = ''
    expect(subject).to_not be_valid
    subject.location = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with text in the cost field' do
    subject.cost = 'a'
    expect(subject).to_not be_valid
  end

  it 'is not valid with no image' do
    subject.image = nil
    expect(subject).to_not be_valid
  end
end
