class CreateSeries < ActiveRecord::Migration[6.1]
  def change
    create_table :series do |t|
      t.string :title
      t.text :description
      t.references :poster, null: false, foreign_key: true

      t.timestamps
    end
  end
end
