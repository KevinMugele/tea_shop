class ChangeStatusToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :subscriptions, :frequency, :integer, using: 'frequency::integer'
  end
end
