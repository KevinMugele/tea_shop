require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
     it { should belong_to(:customer) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_numericality_of(:customer_id) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
    it { should validate_presence_of(:frequency) }
    it { should define_enum_for(:frequency).with_values(%w[Weekly Monthly Annually]) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values(%w[Active Cancelled]) }
    it { should validate_presence_of(:tea_id) }
  end
end
