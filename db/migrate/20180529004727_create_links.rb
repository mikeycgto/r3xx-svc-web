class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.references :user, foreign_key: true, null: true

      t.string     :domain, null: false
      t.string     :ident, null: false
      t.string     :url, null: false

      t.integer    :hits_count, default: 0, null: false

      t.timestamps

      t.index :ident, unique: true
    end
  end
end
