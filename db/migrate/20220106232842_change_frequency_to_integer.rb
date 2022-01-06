class ChangeFrequencyToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :subscriptions, :status, :integer, using: 'status::integer'
  end
end
