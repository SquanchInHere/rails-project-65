# frozen_string_literal: true

class AddStateToBulletin < ActiveRecord::Migration[7.1]
  def change
    add_column :bulletins, :state, :string, default: :draft
  end
end
