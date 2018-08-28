class CreateMisses < ActiveRecord::Migration[5.2]
  def change
    create_table :misses do |t|
      t.string     :link_ident, null: false
      t.string     :domain, null: false
      t.string     :remote_address, null: false
      t.string     :user_agent, null: false

      t.boolean    :recorded_as_hit, default: false, null: false

      t.string     :location_country_code
      t.string     :location_country_name
      t.string     :location_region_name
      t.string     :location_city_name

      t.string     :client_browser_name
      t.string     :client_browser_version
      t.string     :client_device_name
      t.string     :client_device_type
      t.string     :client_os_name
      t.string     :client_os_version

      t.timestamps
    end

    add_index :misses, :link_ident
    add_index :misses, :created_at
  end
end
