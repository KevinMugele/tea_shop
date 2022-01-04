class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    json_response(SubscriptionSerializer.new(subscriptions))
  end

  def create
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.create!(subscription_params)
    json_response(SubscriptionSerializer.new(subscription))
  end

  def update
    customer = Customer.find(params[:customer_id])
    subscription = Subscription.find(params[:id])
    customer.subscriptions.find(subscription.id)
    subscription.update!(subscription_params)
    json_response(SubscriptionSerializer.new(subscription))
  end

  def subscription_params
    params.permit(:title, :tea_id, :price, :frequency, :status, :customer_id)
  end
end
