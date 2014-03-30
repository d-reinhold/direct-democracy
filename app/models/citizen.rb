class Citizen < ActiveRecord::Base
  belongs_to :rep
  has_many :votes
  has_many :bills, through: :votes
  has_and_belongs_to_many :tags
end
