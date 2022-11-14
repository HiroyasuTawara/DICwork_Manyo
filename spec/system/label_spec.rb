#require 'rails_helper'
#binding.irb
#RSpec.describe 'ラベル管理機能', type: :system do
#
#  let!(:normal_user) { FactoryBot.create(:normal_user) }
#  before do
#    @current_user = User.find_by(email: "normal@sample.com")
#    visit new_session_path
#    fill_in 'メールアドレス', with: 'normal@sample.com'
#    fill_in 'パスワード', with: '123456'
#    click_button 'ログイン'
#
#  end
#
#  describe '登録機能' do
#
#    context 'ラベルを登録した場合' do
#
##      it '登録したラベルが表示される' do
##        binding.irb
##        visit new_label_path
##        fill_in '名前', with: 'ラベルサンプル'
##        click_button '登録する'
##        expect(page).to have_content 'ラベルサンプル'
##      end
#    end
#  end
#
#  describe '一覧表示機能' do
#    let!(:first_label) { FactoryBot.create(:first_label, user_id: @current_user.id) }
#    context '一覧画面に遷移した場合' do
#      it '登録済みのラベル一覧が表示される' do
#        visit labels_path
#        expect(page).to have_content 'ラベル1'
#      end
#    end
#  end
#end