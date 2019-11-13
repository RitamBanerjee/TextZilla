class CreatePhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_numbers do |t|
      t.string :number, limit: 15, null: false
      t.boolean :not_valid, default: false
    end
  end
end
