# == Schema Information
#
# Table name: products
#
#  id                          :integer          not null, primary key
#  describe                    :text(65535)
#  cover_path                  :string(255)
#  title                       :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  user_id                     :integer
#  user_collect_products_count :integer          default(0)
#  watch_count                 :integer          default(0)
#  status                      :integer          default(1)
#  is_hot                      :boolean          default(FALSE)
#

class Product < ActiveRecord::Base
  # include Obfuscate
  include Commentable
  include Searchable
  include TextCheck

  # elasticsearch
  settings do
    mapping do
      indexes :title,      analyzer: 'snowball'
      indexes :sanitize_describe
    end
  end
  def as_indexed_json(options={})
    self.as_json(
      only: [:id, :status, :title],
      methods: [:sanitize_describe]
      )
  end

  # 保存之前
  before_create :rand_watch_count

  # 发布人
  belongs_to :user
  # 收藏
  has_many :user_collect_products, dependent: :destroy
  # has_many :collected_user, through: :user_collect_products, source: :user
  # 分类
  has_many :product_category_ships, dependent: :destroy
  has_many :categories, through: :product_category_ships

  # 验证
  validates_presence_of :user, :cover_path
  validates :title, presence: true, length: { maximum: 30 }
  validates :describe, presence: true, length: 10..8000

  # 排序
  scope :category_for, ->(category_name) { joins(:categories).where("categories.name = ?", category_name)}
  scope :published, -> { where("status = ?", 1) }
  scope :hot, -> { where(is_hot: true) }

  # 商品状态(Product.statuses)
  enum status: { deleted: 0, active: 1 }

  # 图片尺寸
  def cover_path_with_size(width, height)
    "#{self.cover_path}?imageView2/1/w/#{width}/h/#{height}"
  end
  def cover_path_with_width(width)
    "#{self.cover_path}?imageView2/1/w/#{width}"
  end
  def cover_path_with_height(height)
    "#{self.cover_path}?imageView2/1/h/#{height}"
  end

  def list_json(opt={})
    opt = as_json(only: [:id, :title, :watch_count])
    opt['cover_path'] = cover_path_with_height(200)
    opt['price'] = price.to_f
    opt
  end

  def sanitize_describe
    Product.sanitize_text(self.describe)
  end

  # def to_param
 #    encrypt id
 #  end

  private
    def rand_watch_count
      self.watch_count = rand(3..30)
    end
  
end
