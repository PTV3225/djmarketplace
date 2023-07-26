class CreateDjs < ActiveRecord::Migration[7.0]
  def change
    create_table :djs do |t|
      t.integer :rate
      t.text :description
      t.references :genre, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
