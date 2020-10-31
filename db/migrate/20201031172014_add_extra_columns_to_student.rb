class AddExtraColumnsToStudent < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :subject, :string
    add_column :students, :mark, :integer
  end
end
