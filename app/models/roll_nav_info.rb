# == Schema Information
#
# Table name: roll_nav_infos
#
#  id         :integer          not null, primary key
#  cover_path :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :integer          default(0)
#  title      :string(255)
#

class RollNavInfo < ActiveRecord::Base

  # 图片尺寸
  def cover_path_with_size(width, height)
    "#{self.cover_path}?imageView2/1/w/#{width}/h/#{height}"
  end

  def list_json(opt={})
    opt = as_json(only: [:id, :title, :cover_path])
    opt['cover_path'] = cover_path_with_size(300, 150)
    opt
  end

end
