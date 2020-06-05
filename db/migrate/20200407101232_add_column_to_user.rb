# frozen_string_literal: true

class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, default: '名無しさん'
    add_column :users, :username, :string, default: 'Anonymous'
    add_column :users, :profile, :text
    add_column :users, :link, :string
    add_column :users, :tel, :string
    add_column :users, :sex, :string
  end
end
