# frozen_string_literal: true

require 'faraday'
require 'json'

class Resolvers::PolicyResolver < Resolvers::BaseResolver
  type Types::PolicyType, null: false

  argument :id, ID, required: true

  CACHE_EXPIRATION = 30.seconds

  def resolve(id:)
    cached_policy = read_cached_policy(id)

    if cached_policy
      cached_policy
    else
      policy = fetch_policy(id)
      cache_policy(id, policy) if policy
      policy
    end
  end

  private

  def read_cached_policy(id)
    Rails.cache.read("policy_#{id}")
  end

  def cache_policy(id, policy)
    Rails.cache.write("policy_#{id}", policy, expires_in: CACHE_EXPIRATION)
  end

  def fetch_policy(id)
    response = Faraday.get("http://api_rest:3000/policies/#{id}")
    return nil unless response.success?

    JSON.parse(response.body)
  rescue Faraday::Error => e
    puts "Error fetching policy: #{e.message}"
    nil
  rescue JSON::ParserError => e
    puts "Error parsing JSON: #{e.message}"
    nil
  end
end
