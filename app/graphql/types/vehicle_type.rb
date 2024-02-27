# frozen_string_literal: true

module Types
  class VehicleType < Types::BaseObject
    field :make, String, null: true
    field :model, String, null: true
    field :year, String, null: true
    field :plate, String, null: true
  end
end
