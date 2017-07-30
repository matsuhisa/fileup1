class Address < ApplicationRecord
  belongs_to :prefecture
  belongs_to :user

  enum kind_id: { home: 1, office: 2 }
end
