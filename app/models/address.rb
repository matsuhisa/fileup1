class Address < ApplicationRecord
  belongs_to :prefecture
  belongs_to :user

  validates :municipality, presence: true, allow_blank: true

  enum kind_id: { home: 1, office: 2 }
end
