class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.integer :number
      t.integer :cvc
      t.date :expiration_date
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
