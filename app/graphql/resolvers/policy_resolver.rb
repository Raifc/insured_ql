# frozen_string_literal: true

require 'faraday'
require 'json'

class Resolvers::PolicyResolver < Resolvers::BaseResolver
  type Types::PolicyType, null: false

  argument :id, ID, required: true

  def resolve(id:)
    response = Faraday.get("http://api_rest:3000/policies/#{id}")

    return unless response.success?

    JSON.parse(response.body)
  end
end
