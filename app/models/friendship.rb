class Friendship < ActiveRecord::Base
    belongs_to :user
    #belongs to friend, and the friend is class user.since friend has no class
    belongs_to :friend, :class_name => 'User'
end
