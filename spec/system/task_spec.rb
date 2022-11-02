require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # テストで使用するためのタスクを作成
  before do
    FactoryBot.create(:task) 
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タスク名', with:'お買い物'
        fill_in 'メモ', with:'イオンに行く'
        click_button '登録する'
        expect(page).to have_content 'お買い物' && 'イオンに行く'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      # タスク一覧ページに遷移
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時降順で表示される' do
        task_list = all('.task_row')
        expect(task_list[0].text).to have_content 'name_3'
        expect(task_list[1].text).to have_content 'name_2'
        expect(task_list[2].text).to have_content 'name'
      end
    end
    context '新規タスクを作成した場合' do
      it '新しいタスクが最初に表示される' do
        FactoryBot.create(:fourth_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0].text).to have_content 'name_4'
      end
    end
    end
  end

  describe 'ソート機能' do
    before do
      FactoryBot.create(:task) 
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
    end
    context '「終了期限」リンクを踏んだ場合' do
      it '終了期限降順でタスク一覧が表示される' do
        visit tasks_path
        click_link("終了期限")
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'name_3'
      end
    end
  end

  describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:task, note: 'note')
          visit task_path(task.id)
          expect(page).to have_content 'note'
        end
      end
    
  
  
end