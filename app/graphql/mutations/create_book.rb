class Mutations::CreateBook < Mutations::BaseMutation
  argument :title, String, required: true
  argument :user_id, ID, required: true
  

  field :book, Types::BookType, null: false
  field :errors, [String], null: false

  def resolve(title:, user_id:)
    user = User.find(user_id)
    book = user.books.build(title: title)
    if book.save
      # Successful creation, return the created object with no errors
      {
        book: book,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        book: nil,
        errors: book.errors.full_messages
      }
    end
  end
end