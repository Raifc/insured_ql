module Types
  class InsuredPersonInput < GraphQL::Schema::InputObject
    graphql_name "InsuredPersonInput"
    argument :name, String, required: true
    argument :document_number, String, required: true
  end
end
