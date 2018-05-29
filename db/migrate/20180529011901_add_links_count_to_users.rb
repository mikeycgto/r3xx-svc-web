class AddLinksCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :links_count, :integer, default: 0, null: false
  end
end
