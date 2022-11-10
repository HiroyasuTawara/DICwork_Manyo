require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  let!(:normal_user) { FactoryBot.create(:normal_user) }
  before do
    @current_user = User.find_by(email: "normal@sample.com")
  end

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', note: '失敗テスト', user_id:@current_user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', note: '', user_id:@current_user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が文字数超過の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', note: 'a' * 1025, user_id:@current_user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルが記載され、詳細が1024文字以内の場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', note: 'a' * 1024, expired_at:'2032/11/01' , user_id:@current_user.id)
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it '検索ワードを含むタスクが絞り込まれる' do
        # タイトルの検索メソッドをsearch_nameとしてscopeで定義
        # scopeを使って定義した検索メソッドに検索ワードを挿入する
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
        expect(Task.search_name('name_chiken')).to include(task)
        expect(Task.search_name('name_chiken')).not_to include(second_task)
        expect(Task.search_name('name_chiken')).not_to include(third_task)
        expect(Task.search_name('name_chiken').count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        expect(Task.search_status('1')).to include(task)
        expect(Task.search_status('1')).not_to include(second_task)
        expect(Task.search_status('1')).not_to include(third_task)
        expect(Task.search_status('1').count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索ワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        expect(Task.search_name('name_chiken').search_status('1')).to include(task)
        expect(Task.search_name('name_chiken').search_status('1')).not_to include(second_task)
        expect(Task.search_name('name_chiken').search_status('1')).not_to include(third_task)
        expect(Task.search_name('name_chiken').search_status('1').count).to eq 1
      end
    end
  end
end