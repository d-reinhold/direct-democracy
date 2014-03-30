class Rep < ActiveRecord::Base
  has_many :citizens
  has_many :bills, through: :votes
end
