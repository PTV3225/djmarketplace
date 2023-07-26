class AddPhotoToDjs < ActiveRecord::Migration[7.0]
  def change
    add_column :djs, :photo, :string
  end
end
