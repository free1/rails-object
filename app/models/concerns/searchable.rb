module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    # todo 合并
    class << self
      def simple_search(q)
        search(
          query: {
            multi_match: {
              fields: ['title', 'content'],
              query: q
            }
        })
      end

      def location_search(query)
        search(
          filter: {
            geo_distance: {
                distance: query[:radius], #半径
                location: {
                  lon: query[:longitude],
                  lat: query[:latitude]
                }
            }
          }
        )
      end
    end

  end
end
