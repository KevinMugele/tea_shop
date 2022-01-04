class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :customer_id, presence: true, numericality: true
  validates :tea_id, presence: true
  validates :price, presence: true, numericality: true
  validates :frequency, presence: true
  validates :status, presence: true
end
