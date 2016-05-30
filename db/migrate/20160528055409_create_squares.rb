class CreateSquares < ActiveRecord::Migration[5.0]
  def change
    create_table :squares do |t|
      t.string :title
      t.integer :position
      t.boolean :used, default: false
      t.boolean :usable, default: false
      t.references :project, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
