require "activerecord"

class Project < ActiveRecord::Base
	has_many :pledges
	has_many :users, through: :pledges
end

class User < ActiveRecord::Base
	has_many :pledges
	has_manny :projects, through: :pledges
end

class Pledge < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
end
