class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  # def attributes(*args)
  #   object.attributes.symbolize_keys
  # end
end
