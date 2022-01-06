require 'rails_helper'

describe 'Subscriptions::Update', type: :request do
  describe 'PATCH /api/v1/customers/:customer_id/subscriptions/:id' do
    let!(:customer) { create(:customer) }
    let!(:subscription1) { create(:subscription, status: 'Active', customer: customer) }
    let(:subscription) { customer.subscriptions.first }
    let(:json) { JSON.parse(response.body, symbolize_names: true) }
    let(:json_data) { json[:data] }

    context 'when an existing customer wants to cancel an active subscription' do
      before do
        patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: { status: 'Cancelled' }
      end

      it 'cancels the subscription for the customer' do
        expect(json).not_to be_empty
        expect(json_data.size).to eq 3

        expect(json_data[:attributes].size).to eq 6
        expect(json_data[:attributes][:customer_id]).to eq subscription.customer_id
        expect(json_data[:attributes][:tea_id]).to eq subscription.tea_id
        expect(json_data[:attributes][:title]).to eq subscription.title
        expect(json_data[:attributes][:price]).to eq subscription.price
        expect(json_data[:attributes][:frequency]).to eq subscription.frequency
        expect(json_data[:attributes][:status]).not_to eq subscription.status
      end
    end

    context 'when the customer does not exist' do
      let(:bad_customer_id) { customer.id + 1 }
      let(:errors) { ["Couldn't find Customer with 'id'=#{bad_customer_id}"] }

      before { patch "/api/v1/customers/#{bad_customer_id}/subscriptions/#{subscription.id}", params: {} }

      it 'returns an error that the customer cannot be found' do
        expect(json).not_to be_empty
        expect(json[:errors]).to eq errors
      end
    end

    context 'when the subscription does not exist' do
      let(:bad_id) { subscription.id + 1 }
      let(:errors) { ["Couldn't find Subscription with 'id'=#{bad_id}"] }

      before { patch "/api/v1/customers/#{customer.id}/subscriptions/#{bad_id}", params: {} }

      it 'returns an error that the subscription cannot be found' do
        expect(json).not_to be_empty
        expect(json[:errors]).to eq errors
      end
    end

    context 'when the params are invalid' do
      let(:errors) { ["'TESTING' is not a valid status"] }

      before { patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: { status: 'TESTING' } }

      it 'returns an error messages' do
        expect(json).not_to be_empty

        expect(json[:errors]).to eq errors
      end
    end
  end
end
