# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'GraphQL Policy query' do
  let(:query_string) do
    <<-QUERY
    {
      policy(id: "1") {
        policyId
        effectiveFrom
        effectiveUntil
        vehicle {
          make
        }
      }
    }
    QUERY
  end

  let(:response_body) do
    {
      data: {
          policy: {
            policyId: 1,
            effectiveFrom: '2024-02-23',
            effectiveUntil: '2024-03-23',
            vehicle: {
                  make: 'Toyota'
              }
          }
      }
    }.to_json
  end

  context 'when the policy is found' do
    before do
      stub_request(:get, 'http://api_rest:3000/policies/1')
        .to_return(status: 200, body: response_body, headers: { 'Content-type': 'application/json' })
    end

    it 'returns the policy' do
      post '/graphql', params: { query: query_string }

      response = JSON.parse(response_body)

      expect(response['data']['policy']['policyId']).to eq(1)
      expect(response['data']['policy']['effectiveFrom']).to eq('2024-02-23')
      expect(response['data']['policy']['vehicle']['make']).to eq('Toyota')
    end
  end
end
