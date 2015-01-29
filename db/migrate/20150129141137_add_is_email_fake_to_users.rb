class AddIsEmailFakeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_email_fake, :boolean, null: false, default: false
  end
end
