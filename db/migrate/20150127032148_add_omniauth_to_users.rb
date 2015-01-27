class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_uid,       :string, index: true
    add_column :users, :twitter_uid,      :string, index: true
    add_column :users, :google_oauth2_uid,:string, index: true
  end
end
