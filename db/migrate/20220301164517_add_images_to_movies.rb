class AddImagesToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :images, :string, array: true, default: []
  end
end
