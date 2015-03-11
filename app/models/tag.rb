class Tag < ActiveRecord::Base

	has_many :user_tag_ships, dependent: :destroy
	has_many :users, through: :user_tag_ships

	class << self
		def tokens(query)
			tags = where("name LIKE ?", "%#{query}%")
			if tags.empty?
				[{id: "<<<#{query}>>>", name: "你的专属: \"#{query}\""}]
			else
				tags
			end
		end

		def ids_from_tokens(tokens)
			tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
			tokens.split(',')
		end
	end
end
