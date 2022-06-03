class CreateBeers < ActiveRecord::Migration[7.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :brand
      t.belongs_to :user, foreign_key: true 

      t.timestamps
    end
  end
end
