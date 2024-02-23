module Types
  class VehicleInput < GraphQL::Schema::InputObject
    graphql_name "VehicleInput"
    argument :plate, String, required: true
    argument :make, String, required: true
    argument :model, String, required: true
    argument :year, Int, required: true
  end
end
