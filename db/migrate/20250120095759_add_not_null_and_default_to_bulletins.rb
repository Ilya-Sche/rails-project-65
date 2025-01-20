class AddNotNullAndDefaultToBulletins < ActiveRecord::Migration[7.2]
  def change
    change_column_null :bulletins, :state, false
    change_column_default :bulletins, :state, 'draft'
  end
end
