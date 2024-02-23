# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :createPolicy, mutation: Mutations::CreatePolicy
  end
end
