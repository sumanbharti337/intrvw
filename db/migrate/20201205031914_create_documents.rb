class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.integer :doc_type
      t.string :name
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
