require 'rails_helper'

RSpec.feature 'ユーザページ', type: :feature do
  before { create(:prefecture) }

  scenario 'indexにアクセスする' do
    visit users_path
    expect(page).to have_title 'Fileup1'
  end

  scenario 'ユーザのみ登録する' do
    visit users_path
    expect(page).to have_title 'Fileup1'

    click_on 'New User'
    expect(page).to have_content '新規ユーザー登録'

    fill_in 'user_registration_form[age]', with: '20'
    fill_in 'user_registration_form[name]', with: '山田'
    click_button 'Save'

    expect(page).to have_content 'User was successfully'
  end

  scenario 'ファイルアップロードをする', js: true do
    visit users_path
    expect(page).to have_title 'Fileup1'

    click_on 'New User'
    expect(page).to have_content '新規ユーザー登録'

    fill_in 'user_registration_form[name]', with: '佐藤'
    fill_in 'user_registration_form[age]', with: '20'
    fill_in 'user_registration_form[addresses_attributes][0][municipality]', with: '帯広市'
    attach_file 'user_registration_form[post_images_attributes][0][file_name]', "#{Rails.root}/spec/images/octocat.png"
    attach_file 'user_registration_form[post_images_attributes][1][file_name]', "#{Rails.root}/spec/images/octocat.png"
    click_button 'Save'

    expect(page).to have_content 'User was successfully'
    user = User.find_by(name: '佐藤')
    expect(user.post_images.size).to eq 2
  end
end
