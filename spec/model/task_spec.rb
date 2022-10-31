require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', note: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が文字数超過の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', note: 'a' * 1025)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトル記載され、詳細が1024文字以内の場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功テスト', note: 'a' * 1024)
        expect(task).to be_valid
      end
    end
  end
end