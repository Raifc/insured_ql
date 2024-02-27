require 'faraday'
require 'json'

class Resolvers::PolicyResolver < Resolvers::BaseResolver
  type Types::PolicyType, null: false

  argument :id, ID, required: true

  def resolve(id:)
    response = Faraday.get("http://api_rest:3000/policies/#{id}")

    if response.success?
      parsed_response = JSON.parse(response.body)
      policy_data = parsed_response['policy']
      {
        policy_id: policy_data['policy_id'],
        effective_from: policy_data['effective_from'],
        effective_until: policy_data['effective_until'],
        customer: policy_data['customer'],
        vehicle: policy_data['vehicle']
      }
    end
  end
end
