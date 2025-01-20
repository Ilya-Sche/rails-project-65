class AddNotNullToTitleInBulletins < ActiveRecord::Migration[7.2]
  def change
    change_column_null :bulletins, :title, false
  end
end
