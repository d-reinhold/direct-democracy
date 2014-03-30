class Tag < ActiveRecord::Base
  has_and_belongs_to_many :citizens
  has_and_belongs_to_many :reps
end
