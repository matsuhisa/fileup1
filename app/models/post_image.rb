class PostImage < ApplicationRecord
  belongs_to :user, optional: true
  attr_accessor :file_path

  validates :file_name, presence: true

  PUBLIC_IMAGE_PATH = '/images/'
end
