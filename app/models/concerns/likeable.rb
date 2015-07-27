# module Likeable
#   extend ActiveSupport::Concern

#   included do
#     has_many :user_collects, as: :listable, dependent: :destroy
#     has_many :collected_user, through: :user_collects, source: :listable, source_type: 'User'
#   end
# end