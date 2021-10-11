require 'rails_helper'

RSpec.describe 'Task model function', type: :model do

  describe 'Validation test' do
    context 'If the task Name is empty' do
      it "Task must not be registered" do
        task = Task.new(name: '', detail: 'Failure test')
        expect(task).not_to be_valid
      end
    end
    context 'If the task details are empty' do
      it 'Validation is caught' do
        task = Task.new(name: 'rspec', detail:'')
        expect(task).not_to be_valid
      end
    end
    context 'If the task Title and details are described' do
      it 'Validation passes' do
        task1 = Task.new(name: 'rspec', detail:'this validation must pass')
      end
    end
  describe 'Search function' do
    let!(:task) { FactoryBot.create(:task, name: 'Title 3 made by Factory', detail: 'Default content created by Factory 3', deadline: '2024-10-01', status: 'completed') }
    let!(:second_task) { FactoryBot.create(:task, name: 'Title 1 made by Factory', detail: 'Default content created by Factory 1', deadline: '2024-10-01', status: 'unstarted') }
    let!(:third_task) { FactoryBot.create(:task, name: 'Title 2 made by Factory', detail: 'Default content created by Factory 2', deadline: '2024-10-01', status: 'in progress') }
    let!(:task1) { FactoryBot.create(:task, name: 'task', detail: 'testing factory', deadline: '2024-10-01', status: 'completed') }
    context 'Title is performed by scope method' do
      it "Tasks containing search keywords are narrowed down" do
        # title_seach is a Title search method presented by scope. The method name can be arbitrary.
        expect(Task.search('made')).to include(task)
        expect(Task.search('Facto')).not_to include(task1)
        expect(Task.search('made').count).to eq 3
      end
    end

    context 'Status is performed by scope method' do
      it "Tasks containing search keywords are narrowed down" do
        # title_seach is a Title search method presented by scope. The method name can be arbitrary.
        expect(Task.search_status('completed')).to include(task)
        expect(Task.search_status('completed')).not_to include(second_task)
        expect(Task.search_status('in progress').count).to eq 1
      end
    end

    context 'Title and status is performed by scope method' do
      it "Tasks containing search keywords are narrowed down" do
        # title_seach is a Title search method presented by scope. The method name can be arbitrary.
        expect(Task.search('made').search_status('completed')).to include(task)
        expect(Task.search('Facto').search_status('unstarted')).not_to include(task)
        expect(Task.search('made').search_status('completed').count).to eq 1
      end
    end
  end

  end
end
