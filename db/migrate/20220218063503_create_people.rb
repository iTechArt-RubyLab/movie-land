class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :surname
      t.date :birthday
      t.date :deathday
      t.references :country, null: false, foreign_key: true
      t.boolean :married

      t.timestamps
    end
  end
end
