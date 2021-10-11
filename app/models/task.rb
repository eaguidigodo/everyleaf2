class Task < ApplicationRecord
    belongs_to :user
    validates :name, :detail, :deadline, presence: true

    enum priority: {  Low: 0, Medium: 1, High: 2 }

    scope :search, -> (param) { where("name LIKE ?" , "%#{param}%") }

    scope :search_status, -> (param) { where(status: param) }
end
