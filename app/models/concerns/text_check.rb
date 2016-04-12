# 文本处理
module TextCheck
  extend ActiveSupport::Concern

  def content=(content)
    pipeline = HTML::Pipeline.new [HTML::Pipeline::MentionFilter], {base_url: '/users'}
    result = pipeline.call content
    self[:content] = content
    self[:content_html] = result[:output].to_html
  end

  module ClassMethods
  end

end