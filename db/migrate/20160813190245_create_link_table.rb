class CreateLinkTable < ActiveRecord::Migration
  def change
    create_table(:links) do |t|
      t.integer :description_id

      t.timestamps
    end
  end
end
