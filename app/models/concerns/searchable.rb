module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: { number_of_shards: 1, number_of_replicas: 0 }  do
      mapping do
        indexes :title,      analyzer: 'snowball'
        indexes :id
        indexes :content
      end
    end

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
    end

  end
end
