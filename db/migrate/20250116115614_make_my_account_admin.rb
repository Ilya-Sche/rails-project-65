class MakeMyAccountAdmin < ActiveRecord::Migration[7.2]
  def change
    user = User.find_or_create_by(email: "ilya_sche@mailfence.com")
    user.update(admin: true) if user.persisted?
  end
end
