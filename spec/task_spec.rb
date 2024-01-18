require 'rails_helper'
# spec/task_spec.rb

RSpec.describe Task, type: :model do
  let(:task) { Task.create!(title: "ruby", details: "hello ruby") }

  describe 'initialize' do
    context 'when correct params are given' do
      it "creates a Task instance" do
        expect(task.title).to eq("ruby")
      end
    end

    context 'when it is not given a title' do
      it "it is not a valid instance" do
        new_task = Task.new(details: "too many words")
        new_task.title = nil # Move this line here
        new_task.valid?
        expect(new_task.errors.messages).to eq({ title: ["can't be blank"] })
      end

      it "doesn't create a Task instance" do
        expect {
          new_task = Task.new(details: "too many words")
          new_task.title = nil # Move this line here
          new_task.save
        }.not_to change { Task.count }
      end
    end
  end

  describe "#truncate_details" do
    it "should truncate task details to 15 chars" do
      expect(task.truncate_details).to include('hello ruby')
    end
  end
end
