# encoding=utf-8
module ApplicationHelper

	# 浏览器顶部标题
	def full_title(page_title)
		base_title = "创客家族"
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
	  	# 当前选中的链接是否是a标签
	  	if has_link
				link_to link_text, link_path
			else
				link_to_unless_current link_text, link_path	  		
	  	end
	  end
	end

	# 两种class切换(比如收藏)
	def switch_link(link_path, class_name, link_method, title=nil, link_text='')
		
		link_to link_text, link_path, class: class_name, method: link_method, remote: true
	end

end
