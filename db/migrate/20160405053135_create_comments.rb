class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :article, index:true
      t.references :user, index: true
      t.references :parent, index: true
      t.timestamps null: false
    end
  end
end
