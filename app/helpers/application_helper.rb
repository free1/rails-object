module ApplicationHelper

	def full_title(page_title)
		base_title = "微店"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	# bootstrap导航链接组
	def nav_link(link_text, link_path, class_name)
	  class_name = current_page?(link_path) ? class_name : ''

	  content_tag(:li, :class => class_name) do
	  	link_to_unless_current link_text, link_path
	  end
	end

end
