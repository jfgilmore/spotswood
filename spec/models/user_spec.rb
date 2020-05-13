require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  subject { described_class.new(name: 'Tiny Tim', email: 'tim@test.com', password: '111111', role: :User) }

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

    it 'is not valid with a name less than 2 characters' do
      subject.name = 't'
      expect(subject).to_not be_valid
    end

    it 'is not valid with a name greater than 50 characters in length' do
      subject.name = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'
      expect(subject).to_not be_valid
    end

    it 'is not valid with an invalid email address' do
      subject.email = 'abc'
      expect(subject).to_not be_valid
    end

    it 'is not valid with no email address' do
      subject.email = ''
      expect(subject).to_not be_valid
    end

    context 'with a duplicate email' do
      it 'is not valid' do
        otheruser = described_class.create(name: 'Tiny Tim', email: 'tim@test.com', password: '111111', role: :User)
        expect(subject).to_not be_valid
      end
    end

    it 'is not valid when code of conduct unaccepted' do
      subject.coc = false
      expect(subject).to_not be_valid
    end

    it 'is valid when code of conduct accepted' do
      subject.coc = true
      expect(subject).to be_valid
    end

    context 'when creating a user', method: :create do
      it 'is valid when user role is not present' do
        subject.role = nil
        expect(subject).to be_valid
      end
    end

    context 'when updating a user', method: :update do
      it 'is not valid when user role is not present' do
        subject.role = nil
        expect(subject).to_not be_valid
      end
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
