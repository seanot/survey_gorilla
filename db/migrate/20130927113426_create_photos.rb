class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :user
      t.string     :name
      t.string     :file

      t.timestamps
    end
  end
end
