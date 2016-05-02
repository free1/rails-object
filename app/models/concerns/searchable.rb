module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name    "weixin_test-#{Rails.env}"
    document_type "product"

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
      end

      # 复杂筛选查询(输出统计结果: Product.filter_search(option).aggregations)
      # def filter_search(option={})
      #   filter_option_result = Product.es_filter_option(option)
      #   query_option_result = Product.es_query_option(option)
      #   data = search(
      #     query: {
      #       filtered: {
      #         query: {
      #           bool: {
      #             should: query_option_result
      #           }
      #         },
      #        filter: {
      #          bool: {
      #            must: filter_option_result
      #          }
      #        }
      #       }
      #     },
      #     filter: {
      #       and: [
      #         { exists: { field: "cover_path" }},
      #         { range: { status: {to: 2, from: 0, include_lower: true} }},
      #       ]
      #     },
      #     sort: [
      #      Product.es_sort(option[:sort]) || {}
      #     ],
      #     aggs: { 
      #       titles: { 
      #         terms: { 
      #           field: 'title' 
      #         }
      #       },
      #       brands: { 
      #         terms: { 
      #           field: 'brand.name' 
      #         }
      #       }
      #     }
      #   )
      # end
      # # 拼接es query匹配
      # def es_query_option(option)
      #   search_query_option = []
      #   if option[:query].present?
      #     query = option[:query].strip
      #     search_query_option << { multi_match: {fields: [:_all], boost: 0.8, query: query} }
      #     search_query_option << {
      #       multi_match: {
      #         fields: ["xxx"],
      #         boost: 3.0,
      #         query: query
      #       }
      #     }
      #   end
      #   search_query_option << { match_all: {} } if search_query_option.empty?
      #   search_query_option
      # end

      # # 拼接es筛选项匹配
      # def es_filter_option(option)
      #   search_filter_option = []
      #   # 筛选项
      #   if option[:filters].present?
      #     filters = option[:filters].split
      #     filters_dsl = { or: { filters: [{ terms: { "filters.xx": filters }}, { terms: { "filters": filters } }] } }
      #     search_filter_option << filters_dsl
      #   end
      #   # 价格区间
      #   min_price = option[:min_price] || 2
      #   max_price = option[:max_price] || 1000000
      #   search_filter_option << {
      #     range: {
      #       'price':  {
      #         gte: min_price.to_f,
      #         lte: max_price.to_f
      #       }
      #     }
      #   }
      #   search_filter_option
      # end
      # # es排序
      # def es_sort(rule)
      #   case rule
      #   when "hot"
      #     {watch_count: "desc"}
      #   when "price_desc"
      #     {"price": 'desc'}
      #   when "price"
      #     {"price": 'asc'}
      #   end
      # end

      # 地理位置
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
