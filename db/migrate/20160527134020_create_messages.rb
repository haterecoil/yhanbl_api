class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :text
      t.datetime :sent_on
      t.datetime :read_on
      t.datetime :answered_on

      t.references :sender
      t.references :recipient

      t.timestamps null: false
    end
  end
end
