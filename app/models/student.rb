class Student < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  # searchkick word_middle: [:name]
end
