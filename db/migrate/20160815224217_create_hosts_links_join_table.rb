class CreateHostsLinksJoinTable < ActiveRecord::Migration
  def change
    create_table :hosts_links, :id => false do |t|
      t.integer :host_id
      t.integer :link_id
    end
  end
end
