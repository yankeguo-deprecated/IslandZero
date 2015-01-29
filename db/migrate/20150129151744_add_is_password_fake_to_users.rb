class AddIsPasswordFakeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_password_fake, :boolean, null: false, default: false
  end
end
