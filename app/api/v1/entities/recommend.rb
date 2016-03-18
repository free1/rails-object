module V1
  module Entities
    class Recommend < Grape::Entity
    	root 'recommend'
      expose :title
      expose :cover_path, as: :image_path
    end
  end
end
