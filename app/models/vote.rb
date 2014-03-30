class Vote < ActiveRecord::Base
  belongs_to :citizen
  belongs_to :rep
  belongs_to :bill
end
