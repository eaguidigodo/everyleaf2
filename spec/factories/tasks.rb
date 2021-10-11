FactoryBot.define do

  factory :third_task, class: Task do
    name { 'Title 3 made by Factory' }
    detail { 'Default content created by Factory 1' }
    deadline {'2024-10-01'}
    status {'unstarted'}
    priority {'High'}
  end

  factory :task do
    name { 'Title 1 made by Factory' }
    detail { 'Default content created by Factory 2' }
    deadline {'2010-10-01'}
    status {'in progress'}
    priority {'Medium'}
  end
  # Name the test data to be created "second_task"
  # (If you want to name a class that does not exist, optionally specify "Please use test data for this class")
  factory :second_task, class: Task do
    name { 'Title 2 made by Factory' }
    detail { 'Default content 2 made by Factory' }
    deadline { '2022-02-10' }
    status {'completed'}
    priority {'Low'}
  end
end