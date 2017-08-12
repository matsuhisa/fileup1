require 'rails_helper'

RSpec.feature 'ユーザページ', type: :feature do
  scenario 'indexにアクセスする' do
    visit users_path
    expect(page).to have_title 'Fileup1'
  end

  scenario 'ファイルアップロードをする', js: true do
    visit users_path
    expect(page).to have_title 'Fileup1'
    
    click_on 'New User'
    expect(page).to have_content '新規ユーザー登録'

    fill_in 'user_name', with: 'かもねぎ'
    attach_file 'user[post_images_attributes][0][file_name]', "#{Rails.root}/spec/images/octocat.png"
    attach_file 'user[post_images_attributes][1][file_name]', "#{Rails.root}/spec/images/octocat.png"
    click_button 'Save'

    expect(page).to have_content 'User was successfully'
    user = User.find_by(name: 'かもねぎ')
    expect(user.post_images.size).to eq 2
  end
end
