class User < ApplicationRecord
  has_many :addresses
  accepts_nested_attributes_for :addresses
  has_many :post_images
  accepts_nested_attributes_for :post_images

  validates :name, presence: true

  def foo
    'foo'
  end
end
