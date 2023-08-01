class AddLinkToDjs < ActiveRecord::Migration[7.0]
  def change
    add_column :djs, :link, :text
  end
end
