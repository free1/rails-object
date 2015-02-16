module UsersHelper

	def user_avatar(avatar, size)
		path = avatar || 'avatars/1.jpg'
		image_tag path, size: size
	end
	
end
