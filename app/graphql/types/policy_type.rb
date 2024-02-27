require_relative 'customer_type'
require_relative 'vehicle_type'

module Types
  class PolicyType < Types::BaseObject
    field :policy_id, Int, null: true
    field :effective_from, String, null: true
    field :effective_until, String, null: true
    field :customer, Types::CustomerType, null: true
    field :vehicle, Types::VehicleType, null: true
  end
end
