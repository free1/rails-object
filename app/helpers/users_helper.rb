module UsersHelper

	def user_avatar(avatar, size, id)
		path = avatar || 'avatars/1.jpg'
		image_tag(path, size: size, id: id)
	end
	
end
