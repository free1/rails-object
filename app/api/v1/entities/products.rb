module V1
  module Entities
    class Products < Grape::Entity
      root 'products'
      expose :title, :cover_path, :watch_count
    end

    class Product < Grape::Entity
      expose :title, :cover_path, :watch_count, :describe
    end
  end
end
