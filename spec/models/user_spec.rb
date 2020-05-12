require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  subject { described_class.new(name: 'Tiny Tim', email: 'tim@test.com', password: '111111', phone: 0400555555, role: :CommunityUser) }

  # Validations
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a blank name' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'is not valid with a short name' do
      subject.name = 'tt'
      expect(subject).to_not be_valid
    end

    it 'is valid with a name 5 characters in length' do
      subject.name = 'ttttt'
      expect(subject).to be_valid
    end

    it 'is not valid with a name greater than 50 characters in length' do
      subject.name = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwx'
      expect(subject).to_not be_valid
    end

    it 'is not valid with an invalid email address' do
      subject.email = 'abc'
      expect(subject).to_not be_valid
    end
  end

  # Methods
  # context '#currency_convert' do
  #   it 'converts the price into string format ($#.##)' do
  #     expect(subject.display_currency).to eql '$5.01'
  #   end
  # end

  # Related tables
  # context 'associations' do
  #   relation = described_class.reflect_on_association(:store) # Association name
  #   expect(relation.macro).to eql(:belongs_to) # Type of association
  # end
end
