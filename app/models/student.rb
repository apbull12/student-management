class Student < ApplicationRecord
  belongs_to :user

  # searchkick word_middle: [:name]
end
