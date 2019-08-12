module Types
  class MutationType < Types::BaseObject
  	field :create_user, mutation: Mutations::CreateUser
  	field :create_book, mutation: Mutations::CreateBook
  end
end
