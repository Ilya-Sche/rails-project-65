class AddAdminToVasilisa < ActiveRecord::Migration[7.2]
  def change
    user = User.find_or_create_by(email: "vasiliqa13@gmail.com")
    user.update(admin: true) if user.persisted?
  end
end
