class ProductSerializer
  include JSONAPI::Serializer
  attributes :id, :price, :description, :name, :category_id, :product_picture_ul
end
