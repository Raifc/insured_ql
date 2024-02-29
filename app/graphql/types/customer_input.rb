# frozen_string_literal: true

module Types
  class CustomerInput < GraphQL::Schema::InputObject
    graphql_name 'CustomerInput'
    argument :name, String, required: true
    argument :document_number, String, required: true
  end
end
