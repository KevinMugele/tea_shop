include FactoryBot::Syntax::Methods

Subscription.destroy_all
Customer.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

customer_1 = create(:customer)
customer_2 = create(:customer)

tea_1 = create(:tea)
tea_2 = create(:tea)
tea_3 = create(:tea)

subscription_1 = create(:subscription, customer: customer_1, tea: tea_1, status: 'Active')
subscription_2 = create(:subscription, customer: customer_1, tea: tea_2, status: 'Active')
subscription_3 = create(:subscription, customer: customer_2, tea: tea_3, status: 'Cancelled')
