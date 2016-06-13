class AddRejectedOnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :rejected_on, :datetime
  end
end
