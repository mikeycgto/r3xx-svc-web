class CreateHits < ActiveRecord::Migration[5.2]
  def change
    create_table :hits do |t|
      t.references :link, foreign_key: true, null: false

      t.string     :domain
      t.string     :remote_address
      t.string     :user_agent

      t.timestamps
    end

    add_index :hits, :created_at
  end
end
