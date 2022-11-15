require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:normal_user) { FactoryBot.create(:normal_user) }
  describe '登録機能' do
    before do
      @current_user = User.find_by(email: "normal@sample.com")
      visit new_session_path
      fill_in 'メールアドレス', with: 'normal@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
    end
    context 'ラベルを登録した場合' do
      it '登録したラベルが表示される' do
        visit new_label_path
        fill_in 'Name', with: 'ラベルサンプル'
        select 'red', from: 'label_color'
        click_button '登録する'
        expect(page).to have_content 'ラベルサンプル'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'normal@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
    end
    context '一覧画面に遷移した場合' do
      it '登録済みのラベル一覧が表示される' do
        visit labels_path
        expect(page).to have_content 'Your Label List'
      end
    end
  end
end