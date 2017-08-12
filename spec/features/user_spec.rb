require 'rails_helper'

RSpec.feature 'ユーザページ', type: :feature do
  scenario 'indexにアクセスする' do
    visit users_path
    expect(page).to have_title 'Fileup1'
  end
end
