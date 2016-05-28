class CreateSquares < ActiveRecord::Migration[5.0]
  def change
    create_table :squares do |t|
      t.string :title
      t.integer :position, array: true, default: []
      t.references :project, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
