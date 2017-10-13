class CreateSnapspots < ActiveRecord::Migration[5.1]
  def change
    create_table :snapspots do |t|
      t.string :name
      t.string :location
      t.string :description
      t.belongs_to :user, index:true, foreign_key:true

      t.timestamps
    end
  end
end
