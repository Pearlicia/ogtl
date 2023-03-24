class AddBodyToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :body, :text
  end
end
