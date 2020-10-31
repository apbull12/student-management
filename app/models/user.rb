class User < ApplicationRecord
  include Clearance::User

  include Clearance::User

  has_many :students
end
