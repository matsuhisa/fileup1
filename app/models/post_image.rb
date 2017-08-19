class PostImage < ApplicationRecord
  belongs_to :user
  attr_accessor :file_path
end
