# frozen_string_literal: true

class AddAdminToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, default: true, null: false
  end
end
