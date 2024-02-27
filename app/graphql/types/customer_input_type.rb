module Types
  class CustomerInputType < GraphQL::Schema::InputObject
    graphql_name "CustomerInputType"
    argument :name, String, required: true
    argument :document_number, String, required: true
  end
end
