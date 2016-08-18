class CreateDescriptionTable < ActiveRecord::Migration
  def change
    create_table(:descriptions) do |t|
      t.string :text

      t.timestamps
    end
  end
end
