require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:normal_user) { FactoryBot.create(:normal_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'normal@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with:'お買い物'
        fill_in 'メモ', with:'イオンに行く'
        select '低', from: '優先度'
        select '未着手', from: 'ステータス'
        click_button '登録する'
        expect(page).to have_content 'お買い物'
      end
    end
  end

  describe '一覧表示機能' do
    let!(:normal_user) { FactoryBot.create(:normal_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'normal@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
      FactoryBot.create(:task) 
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時降順で表示される' do
        task_list = all('.task_row')
        expect(task_list[0].text).to have_content 'name_3_dog'
        expect(task_list[1].text).to have_content 'name_2_cat'
        expect(task_list[2].text).to have_content 'name_chiken'
      end
    end
    context '新規タスクを作成した場合' do
      it '新しいタスクが最初に表示される' do
        FactoryBot.create(:fourth_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0].text).to have_content 'name_4_donkey'
      end
    end
  end


  describe 'ソート機能' do
    let!(:normal_user) { FactoryBot.create(:normal_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'normal@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
    end
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }
    context '「終了期限」リンクをクリックした場合' do
      it '終了期限昇順でタスク一覧が表示される' do
        visit tasks_path
        rescue Selenium::WebDriver::Error::NoAlertPresentError
        click_link("終了期限")
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'name_2_cat'
      end
    end
    context '「優先度」リンクをクリックした場合' do
      it '優先度降順でタスク一覧が表示される' do
        visit tasks_path
        rescue Selenium::WebDriver::Error::NoAlertPresentError
        click_link("優先度")
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'name_2_cat'
      end
    end
  end

  describe '詳細表示機能' do
    let!(:normal_user) { FactoryBot.create(:normal_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'normal@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, note: 'note')
        visit task_path(task.id)
        expect(page).to have_content 'note'
      end
    end
  end
  
  describe '検索機能' do
    let!(:normal_user) { FactoryBot.create(:normal_user) }
    before do
      visit new_session_path
      fill_in 'メールアドレス', with: 'normal@sample.com'
      fill_in 'パスワード', with: '123456'
      click_button 'commit'
      FactoryBot.create(:task, user: normal_user) 
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
      visit tasks_path
    end
  
    context 'タイトルであいまい検索をした場合' do
      it "検索ワードを含むタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        visit tasks_path
        fill_in 'search[name]', with: 'chiken'
        click_button '検索'
        expect(page).to have_content 'name_chiken'
        expect(page).not_to have_content 'name_2_cat'
        expect(page).not_to have_content 'name_3_dog'
      end
    end
    context 'ステータスで検索した場合' do
      it "検索したステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        visit tasks_path
        select '未着手', from: 'search[status]'
        click_button '検索'
        expect(page).not_to have_content 'name_chiken'
        expect(page).to have_content 'name_2_cat'
        expect(page).to have_content 'name_3_dog'
      end
    end
    context 'タイトルとステータスで検索した場合' do
      it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
        visit tasks_path
        fill_in 'search[name]', with: 'name'
        select '着手', from: 'search[status]'
        click_button '検索'
        expect(page).to have_content 'ame_chiken'
        expect(page).not_to have_content 'name_2_cat'
        expect(page).not_to have_content 'name_3_dog'
      end
    end
  end
end