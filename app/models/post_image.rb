class PostImage < ApplicationRecord
  belongs_to :user
  attr_accessor :file_path

  PUBLIC_IMAGE_PATH = '/images/'
end
