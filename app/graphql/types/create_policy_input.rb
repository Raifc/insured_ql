# frozen_string_literal: true

module Types
  class CreatePolicyInput < GraphQL::Schema::InputObject
    graphql_name 'CreatePolicyInput'
    argument :effective_from, String, required: true
    argument :effective_until, String, required: true
    argument :vehicle, Types::VehicleInputType, required: true
    argument :customer, Types::CustomerInputType, required: true
  end
end
