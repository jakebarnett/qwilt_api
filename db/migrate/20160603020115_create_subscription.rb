class CreateSubscription < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.string :role, default: "collaborator"
      
      t.integer :project_id
      t.integer :user_id
      t.timestamps
    end
    add_index :subscriptions, [:project_id, :user_id]
  end
end
