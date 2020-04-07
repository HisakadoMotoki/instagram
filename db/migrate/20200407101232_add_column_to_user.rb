class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :plofile, :text
    add_column :users, :link, :string
    add_column :users, :tel, :string
    add_column :users, :sex, :integer
  end
end
