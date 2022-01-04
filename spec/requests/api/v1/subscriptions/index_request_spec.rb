require 'rails_helper'

describe 'Subscriptions::Index', type: :request do
  describe 'GET /api/v1/customers/:customer_id/subscriptions' do
    let!(:customer) { create(:customer) }
    let!(:subscription) { create(:subscription, status: 'Cancelled', customer: customer) }

    let(:json) { JSON.parse(response.body, symbolize_names: true) }
    let(:json_data) { json[:data] }

    context 'when an existing customer wants to view their active and cancelled subscriptions' do
      before { get "/api/v1/customers/#{customer.id}/subscriptions" }

      it 'returns the subscriptions for the customer' do
        expect(json).not_to be_empty
        expect(json_data.class).to eq Array
        expect(json_data.size).to eq 1

        json_data.each do |subscription|
          expect(subscription[:id].class).to eq String
          expect(subscription[:type]).to eq 'subscription'
          expect(subscription[:attributes].size).to eq 6
          expect(subscription[:attributes][:customer_id]).to eq customer.id
          expect(subscription[:attributes][:tea_id].class).to eq Integer
          expect(subscription[:attributes][:title].class).to eq String
          expect(subscription[:attributes][:price].class).to eq String
          expect(subscription[:attributes][:frequency].class).to eq String
          expect(subscription[:attributes][:status].class).to eq String
        end
      end
    end

    context 'when the customer does not exist' do
      let(:bad_customer_id) { customer.id + 1 }
      let(:errors) { ["Couldn't find Customer with 'id'=#{bad_customer_id}"] }

      before { get "/api/v1/customers/#{bad_customer_id}/subscriptions" }

      it 'returns an error that the customer cannot be found' do
        expect(json).not_to be_empty
        expect(json[:errors]).to eq errors
      end
    end

    context 'when a customer does not have any subscriptions' do
      let(:new_customer) { create(:customer) }

      before { get "/api/v1/customers/#{new_customer.id}/subscriptions" }

      it 'returns an empty array' do
        expect(json_data.class).to eq Array
      end
    end
  end
end
