class Bill < ActiveRecord::Base
  has_one :rep, through: :votes
  has_many :votes
  has_many :citizens, through: :votes
  has_and_belongs_to_many :tags
end
