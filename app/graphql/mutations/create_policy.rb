# frozen_string_literal: true

require 'bunny'

module Mutations
  class CreatePolicy < BaseMutation # rubocop:disable Style/Documentation
    argument :effective_from, String, required: true
    argument :effective_until, String, required: true
    argument :vehicle_id, ID, required: true
    argument :insured_person_id, ID, required: true

    field :policy, Types::PolicyType, null: true
    field :errors, [String], null: false

    def resolve(effective_from:, effective_until:, vehicle_id:, insured_person_id:)
      connection = Bunny.new(hostname: 'rest_insured_rabbitmq_1')
      connection.start
      channel = connection.create_channel
      queue = channel.queue('policy-created')

      policy = {
        effective_from:,
        effective_until:,
        vehicle_id:,
        insured_person_id:
      }.to_h

      channel.default_exchange.publish(policy, routing_key: queue.name)

      connection.close
    end
  end
end
