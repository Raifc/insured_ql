module Types
  class CreatePolicyInput < GraphQL::Schema::InputObject
    graphql_name "CreatePolicyInput"
    argument :effectiveFrom, String, required: true
    argument :effectiveUntil, String, required: true
    argument :vehicle, Types::VehicleInput, required: true
    argument :Customer, Types::CustomerInput, required: true
  end
end
