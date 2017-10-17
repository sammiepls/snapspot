class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, index:true, foreign_key:true
      t.belongs_to :snapspots, index:true, foreign_key:true
    end
  end
end
