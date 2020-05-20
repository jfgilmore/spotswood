class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :listings, :time, :at_time
  end
end
