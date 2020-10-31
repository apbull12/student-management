class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
