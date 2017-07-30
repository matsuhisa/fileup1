class Address < ApplicationRecord
  belongs_to :prefecture

  enum kind_id: { home: 1, office: 2 }
end
