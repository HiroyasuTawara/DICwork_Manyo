require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # テストで使用するためのタスクを作成
  let!(:task) { FactoryBot.create(:task, name: 'task') }

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
      it '作成済みのタスク一覧が表示される' do
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task'
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
  
end