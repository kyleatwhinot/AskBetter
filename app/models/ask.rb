class Ask < ActiveRecord::Base
  attr_accessible :category, :description, :done, :followed_up, :helper, :public, :user_id
end
