module ApplicationHelper

	def full_title(page_title)
		base_title = "微生活"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	# 用户头像
	def user_avatar(avatar, size, id=nil)
		path = avatar || 'avatars/1.jpg'
		image_tag(path, size: size, id: id)
	end

	# bootstrap导航链接组
	def nav_link(link_text, link_path, class_name, has_link=false)
	  class_name = current_page?(link_path) ? class_name : ''

	  content_tag(:li, class: class_name) do
	  	if has_link
			link_to link_text, link_path
		else
			link_to_unless_current link_text, link_path	  		
	  	end
	  end
	end

end
