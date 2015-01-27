class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_provider, :string, index: true
    add_column :users, :oauth_uid,      :string, index: true
  end
end
