class CreateMisses < ActiveRecord::Migration[5.2]
  def change
    create_table :misses do |t|
      t.string     :link_ident
      t.string     :domain
      t.string     :remote_address
      t.string     :user_agent

      t.boolean    :recorded_as_hit, default: false, null: false

      t.timestamps
    end

    add_index :misses, :created_at
  end
end
