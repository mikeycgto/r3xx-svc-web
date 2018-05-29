class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.references :user, null: true

      t.string     :ident, null: false
      t.string     :url, null: false

      t.integer    :hits, null: false, default: 0

      t.timestamps

      t.index :ident, unique: true
    end
  end
end
