require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe '新規登録機能' do
    context 'ユーザを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_user_path
        fill_in 'ユーザーネーム', with: 'テスト太郎'
        fill_in 'メールアドレス', with: 'tarooo@sample.com'
        fill_in 'パスワード', with: '123456'
        fill_in 'パスワード(確認)', with: '123456'
        click_button '登録する'
        expect(page).to have_content 'Your Tasks'
      end
    end
    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、「ログインを行なってください。」と表示する' do
        visit tasks_path
        expect(page).to have_content 'ログインを行なってください。'
      end
    end
  end
  describe 'ログイン機能' do
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    let!(:normal_user) { FactoryBot.create(:normal_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'administar@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
    end

    context '登録済みユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」と表示する' do
        expect(page).to have_content 'ログインしました'
      end

      it '自身のマイページにアクセスできる' do
        visit user_path(admin_user.id)
        expect(page).to have_content '管理者ユーザー'
      end

      it '他者のマイページにアクセスすると、タスク一覧画面に遷移する' do
        visit user_path(normal_user.id)
        expect(page).to have_content 'Your Tasks'
      end
      
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」と表示する' do
        find("#logout").click
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理者機能' do
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    let!(:normal_user) { FactoryBot.create(:normal_user) }
    let!(:second_user) { FactoryBot.create(:second_user) }

    context '管理者がログインした場合' do
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'administar@sample.com'
        fill_in 'パスワード', with: '123456'
        click_button 'commit'
      end

      it 'ユーザ一覧画面にアクセスできる' do
        find("#users-index").click
        expect(page).to have_content 'Users'
      end

      it 'ユーザーを登録できる' do
        find("#users-index").click
        click_link 'New User'
        expect(page).to have_content 'New User/Admin'
      end

      it 'ユーザ詳細画面にアクセスできる' do
        find("#users-index").click
        click_link 'Show', match: :first
        expect(page).to have_content 'User page/admin'
      end

      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
        find("#users-index").click
        click_link 'Edit', match: :first
        expect(page).to have_content 'Editing User/Admin'
      end

      it 'ユーザを削除できる' do
        find("#users-index").click
        click_link 'Destroy', match: :first
        expect{
          expect(page.accept_confirm).to eq "Are you sure?"
          expect(page).to have_content "アカウントを削除しました/admin"
          }
      end
    end

    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      let!(:first_user) { FactoryBot.create(:first_user) }
      before do
        visit new_session_path
        fill_in 'メールアドレス', with: 'normal@sample.com'
        fill_in 'パスワード', with: '123456'
        click_button 'commit'
      end

      it 'タスク一覧画面に遷移し、エラーメッセージが表示する' do
        visit admin_users_path
        expect(page).to have_content 'このアカウントは管理者専用ページにアクセスできません。'
      end
    end
  end
end