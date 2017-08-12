require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
    let(:user){ create(:user, name: 'かもねぎ') }
    subject{ user.name }

    it { is_expected.to eq 'かもねぎ' }
  end

  describe '#foo' do
    subject{ User.new.foo }

    it { is_expected.to eq 'foo' }
  end
end