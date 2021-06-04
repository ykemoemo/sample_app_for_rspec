require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "バリデーションテスト" do
    let (:task) { build(:task) }

    context "タイトルとステータスがある場合" do
      it "有効であること" do
        expect(task).to be_valid
        expect(task.errors).to be_empty
      end
    end

    context "タイトルが空の場合" do
      it "無効であること" do
        task.title = ""
        expect(task).to be_invalid
        expect(task.errors[:title]).to eq ["can't be blank"]
      end
    end

    context "ステータスが空の場合" do
      it "無効であること" do
        task.status = nil
        expect(task).to be_invalid
        expect(task.errors[:status]).to eq ["can't be blank"]
      end
    end

    context "タイトルが重複している場合" do
      it "無効であること" do
        task = create(:task)
        task_with_duplicated_title = build(:task, title: task.title)
        expect(task_with_duplicated_title).to be_invalid
        expect(task_with_duplicated_title.errors[:title]).to eq ["has already been taken"]
      end
    end
  end
end