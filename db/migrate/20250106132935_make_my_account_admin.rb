class MakeMyAccountAdmin < ActiveRecord::Migration[7.2]
  def change
    User.find_by(email: "123@mail.ru").update(admin: true)
  end
end
