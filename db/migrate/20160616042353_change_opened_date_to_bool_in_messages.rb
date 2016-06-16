class ChangeOpenedDateToBoolInMessages < ActiveRecord::Migration
  def up
    change_column :messages, :opened_on, :boolean
  end

  def down
    change_column :messages, :opened_on, :datetime
  end
end
