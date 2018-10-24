class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :bgg_username
end
