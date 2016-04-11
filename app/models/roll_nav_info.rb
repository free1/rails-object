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

  def list_json(opt={})
    opt = as_json(only: [:id, :title, :cover_path])
    opt
  end

end
