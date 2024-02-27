# frozen_string_literal: true

module Types
  class VehicleInputType < GraphQL::Schema::InputObject
    graphql_name 'VehicleInputType'
    argument :plate, String, required: true
    argument :make, String, required: true
    argument :model, String, required: true
    argument :year, Int, required: true
  end
end
