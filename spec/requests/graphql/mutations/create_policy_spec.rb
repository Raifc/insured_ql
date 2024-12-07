require 'rails_helper'

RSpec.describe Mutations::CreatePolicy, type: :mutation do
  describe '#resolve' do
    let(:mutation) { described_class.new(object: nil, field: nil, context: {}) }
    let(:params) do
      {
        effective_from: '2024-02-23',
        effective_until: '2024-03-23',
        vehicle: {
          plate: 'ABC123',
          make: 'Toyota',
          model: 'Hilux',
          year: 2022
        },
        insured_person: {
          name: 'John Doe',
          document_number: '1234567839'
        }
      }
    end

    it 'creates a policy and publishes it to RabbitMQ' do
      expect(Bunny).to receive(:new).with(hostname: 'rest_insured_rabbitmq_1').and_return(connection_mock = double)
      expect(connection_mock).to receive(:start)
      expect(connection_mock).to receive(:create_channel).and_return(channel_mock = double)
      expect(channel_mock).to receive(:queue).with('policy-created', durable: true).and_return(queue_mock = double)
      expect(queue_mock).to receive(:name).and_return('queue_name')
      expect(channel_mock).to receive(:default_exchange).and_return(default_exchange_mock = double)
      expect(default_exchange_mock).to receive(:publish).with(params.to_json, routing_key: 'queue_name')
      expect(connection_mock).to receive(:close)

      result = mutation.resolve(**params)

      expect(result[:ok]).to eq(true)
      expect(result[:errors]).to be_empty
    end

    it 'returns false and errors when an exception occurs' do
      expect(Bunny).to receive(:new).and_raise('Something went wrong')

      result = mutation.resolve(**params)

      expect(result[:ok]).to eq(false)
      expect(result[:errors]).to eq(['Something went wrong'])
    end
  end
end
