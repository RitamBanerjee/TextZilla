class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :message_id
      t.string :message, null: false
      t.string :status
    end
  end
end
