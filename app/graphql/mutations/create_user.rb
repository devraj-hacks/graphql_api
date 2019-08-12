class Mutations::CreateUser < Mutations::BaseMutation
  argument :name, String, required: true
  argument :email, String, required: true
  argument :title, String, required: true

  field :user, Types::UserType, null: false
  field :books, [Types::BookType], null: false
  field :errors, [String], null: false

  def resolve(name:, email:, title:)
    user = User.new(name: name, email: email)
    if user.save
      user.books.create(title: title)
      # Successful creation, return the created object with no errors
      {
        user: user,
        books: user.books,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end