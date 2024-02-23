module Types
  class PolicyType < Types::BaseObject
    field :ok, Boolean, null: false
    field :errors, [String], null: true
  end
end
