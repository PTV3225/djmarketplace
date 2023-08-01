class AddLocationToDjs < ActiveRecord::Migration[7.0]
  def change
    add_column :djs, :location, :string
  end
end
