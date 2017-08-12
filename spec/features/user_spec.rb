require 'rails_helper'

RSpec.feature 'ユーザページ', type: :feature do
  context 'indexにアクセスする' do

    scenario '' do
      visit users_path
      expect(page).to have_title 'Fileup1'
    end
  end
end
