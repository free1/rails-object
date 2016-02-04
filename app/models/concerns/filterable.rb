module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    # todo product例子
    normal_filters = [
      :category, :gender
    ]
    normal_filters.each do |filter|
      scope filter, -> (param) { where(filter => param) }
    end

    # 动态筛选
    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end