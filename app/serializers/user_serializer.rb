class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :firstName, :lastName, :email, :dob, :phoneNumber, :address, :created_at , :updated_at
end
