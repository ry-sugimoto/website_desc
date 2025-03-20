class CreateWebsites < ActiveRecord::Migration[7.1]
  def change
    create_table :websites do |t|
      t.text :url
      t.text :description

      t.timestamps
    end
  end
end
