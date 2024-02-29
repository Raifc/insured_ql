# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :policy, Types::PolicyType, resolver: Resolvers::PolicyResolver
  end
end
