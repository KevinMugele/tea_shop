require 'rails_helper'

describe 'Subscriptions::Create', type: :request do
  describe 'POST /api/v1/customers/:customer_id/subscriptions' do
    context 'when an existing customer wants to create a new subscription with valid attributes' do
      let(:customer) { create(:customer) }
      let(:tea) { create(:tea) }

      let(:json) { JSON.parse(response.body, symbolize_names: true) }
      let(:json_data) { json[:data] }

      let(:valid_attributes) do
        {
          title: tea.title,
          tea_id: tea.id,
          price: '50',
          frequency: 'Weekly',
          status: 'Active',
          customer_id: customer.id
        }
      end

      before { post "/api/v1/customers/#{customer.id}/subscriptions", params: valid_attributes }

      it 'creates a new subscription for the customer' do
        expect(json).not_to be_empty
        expect(json_data.size).to eq 3

        expect(json_data[:attributes].size).to eq 6
        expect(json_data[:attributes][:customer_id]).to eq valid_attributes[:customer_id]
        expect(json_data[:attributes][:tea_id]).to eq valid_attributes[:tea_id]
        expect(json_data[:attributes][:title]).to eq valid_attributes[:title]
        expect(json_data[:attributes][:price]).to eq valid_attributes[:price]
        expect(json_data[:attributes][:frequency]).to eq valid_attributes[:frequency]
        expect(json_data[:attributes][:status]).to eq valid_attributes[:status]
      end
    end

    context 'when the customer does not exist' do
      let(:customer) { create(:customer) }
      let(:bad_customer_id) { customer.id + 1 }
      let(:json) { JSON.parse(response.body, symbolize_names: true) }
      let(:errors) { ["Couldn't find Customer with 'id'=#{bad_customer_id}"] }

      before { post "/api/v1/customers/#{bad_customer_id}/subscriptions", params: {} }

      it 'returns an error that the customer cannot be found' do
        expect(json).not_to be_empty
        expect(json[:errors]).to eq errors
      end
    end

    context 'when the params are invalid' do
      let(:customer) { create(:customer) }
      let(:tea) { create(:tea) }
      let(:json) { JSON.parse(response.body, symbolize_names: true) }
      let(:json_data) { json[:data] }

      let(:errors) do
        [
          'Tea must exist',
          "Tea can't be blank",
          "Price can't be blank",
          'Price is not a number',
          "Frequency can't be blank",
          "Status can't be blank"
        ]
      end

      before { post "/api/v1/customers/#{customer.id}/subscriptions", params: {} }

      it 'returns error messages' do
        expect(json).not_to be_empty
        expect(json[:errors]).to eq errors
      end
    end
  end
end
