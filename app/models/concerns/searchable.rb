module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name    "weixin_test-#{Rails.env}"
    document_type "product"

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

      def product_search(q)
        search(
          query: {
            multi_match: {
              fields: ['title', 'sanitize_describe'],
              query: q
            }
        })
        #        query_option = Product.es_option(option)
        #        data = search(
        #          query: {
        #              filtered: {
        #                query: {
        #                  multi_match: {
        #                    fields: ['title', 'sanitize_describe'],
        #                    query: option[:q]
        #                  }
        #                },
        #                filter: {
        #                  bool: {
        #                    must: query_option
        #                  }
        #                }
        #              }
        #          },
        #          filter: {
        #              exists: { field: "" }
        #          },
        #
        #          sort: [
        #            Product.es_sort(option[:sort]) || {}
        #          ]
        #        )
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



# # Customize the index name
#     index_name [Rails.application.engine_name, Rails.env].join('_')

#     # Set up index configuration and mapping
#     #
#     settings index: { number_of_shards: 1, number_of_replicas: 0 } do
#       mapping dynamic: false do
#           indexes :id
#           indexes :title, analyzer: 'snowball'
#           indexes :category, index: 'not_analyzed'
#           indexes :category_constant, index: 'not_analyzed'
#           indexes :skier_ability, index: 'not_analyzed'
#           indexes :snow_conditions, index: 'not_analyzed'
#           indexes :turning_radius, index: 'not_analyzed'
#           indexes :rocker_type, index: 'not_analyzed'
#           indexes :width_desc, index: 'not_analyzed'
#           indexes :board_style, index: 'not_analyzed'
#           indexes :price, type: 'double'
#       end
#     end

#     class << self

#       def simple_search(query)
#         search(
#           query: {
#             multi_match: {
#               fields: ['title', 'category', 'category_description', 'detail', 'brand.name'],
#               query: query
#             }
#           }
#         )
#       end

#       def filter_search(option={})
#         query_option = Product.es_option(option)
#         logger.info "--------------search_option--------------------"
#         logger.info query_option
#         search(
#           query: {
#             filtered: {
#               query: {
#                 multi_match: {
#                   fields:  ['title', 'category', 'category_description', 'detail', 'brand.name'],
#                   query: option[:query]
#                 }
#               },
#               filter: {
#                bool: {
#                   must: query_option
#                 }
#               }
#             }
#           }
#          )
#       end

#       # todo
#       def es_option(option)
#         search_option = []
#         if option[:category].present?
#           category = option[:category]
#           category = { term: { "category": category } }
#           search_option << category
#         end
#         if option[:category_constant].present?
#           category_constant = option[:category_constant].split(",")
#           category_constant = { terms: { "category_constant": category_constant } }
#           search_option << category_constant
#         end
#         if option[:skier_ability].present?
#           skier_ability = option[:skier_ability]
#           skier_ability = { term: { "skier_ability": category_constant } }
#           search_option << skier_ability
#         end
#         if option[:snow_conditions].present?
#           snow_conditions = option[:snow_conditions]
#           snow_conditions = { term: { "snow_conditions": snow_conditions } }
#           search_option << snow_conditions
#         end
#         if option[:turning_radius].present?
#           turning_radius = option[:turning_radius]
#           turning_radius = { term: { "turning_radius": turning_radius } }
#           search_option << turning_radius
#         end
#         if option[:rocker_type].present?
#           rocker_type = option[:rocker_type]
#           rocker_type = { term: { "rocker_type": rocker_type } }
#           search_option << rocker_type
#         end
#         if option[:width_desc].present?
#           width_desc = option[:width_desc]
#           width_desc = { term: { "width_desc": width_desc } }
#           search_option << width_desc
#         end
#         if option[:board_style].present?
#           board_style = option[:board_style]
#           board_style = { term: { "board_style": board_style } }
#           search_option << board_style
#         end
#         search_option
#       end

#     end