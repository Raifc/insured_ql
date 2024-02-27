module Types
  class CustomerType < Types::BaseObject
    field :name, String, null: true
    field :cpf, String, null: true
  end
end
