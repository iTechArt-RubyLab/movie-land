class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|
      t.string :title
      t.integer :number
      t.text :description
      t.references :poster, null: false, foreign_key: { to_table: :images }
      t.string :trailer
      t.references :series, null: false, foreign_key: true

      t.timestamps
    end
  end
end
