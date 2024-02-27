module Types
  class PolicyInputType < Types::BaseObject
    field :ok, Boolean, null: false
    field :data, Types::PolicyType, null: true do
      description 'Policy data'
    end
    field :errors, [String], null: true

    def data
      object.data
    end
  end
end
