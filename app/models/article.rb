class Article < ActiveRecord::Base
	belongs_to :user

	enum status: {updating: 0, publish: 1, finished: 2}
end
