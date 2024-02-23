module Types
  class PolicyType < Types::BaseObject
    field :id, ID, null: false
    field :effective_from, String, null: true
    field :effective_until, String, null: true
    field :vehicle, Types::VehicleType, null: true
    field :insured_person, Types::InsuredType, null: true
  end
end
