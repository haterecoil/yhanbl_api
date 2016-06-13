class AddOpenedOnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :opened_on, :datetime
  end
end
