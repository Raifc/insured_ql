# frozen_string_literal: true

module Mutations
  class CreatePolicy < BaseMutation
    argument :effective_from, String, required: true
    argument :effective_until, String, required: true
    argument :vehicle, GraphQL::Types::JSON, required: true
    argument :customer, GraphQL::Types::JSON, required: true

    field :ok, Boolean, null: false
    field :errors, [String], null: false

    def resolve(effective_from:, effective_until:, vehicle:, customer:)
      connection = Bunny.new(hostname: 'rest_insured_rabbitmq_1')
      connection.start
      channel = connection.create_channel
      queue = channel.queue('policy-created', durable: true)

      policy_payload = {
        effective_from: effective_from,
        effective_until: effective_until,
        vehicle: vehicle,
        customer: customer
      }.to_json

      channel.default_exchange.publish(policy_payload, routing_key: queue.name)

      connection.close

      { ok: true, errors: [] }
    rescue StandardError => e
      { ok: false, errors: [e.message] }
    end

    private

    def parse_policy
      
    end
  end
end
