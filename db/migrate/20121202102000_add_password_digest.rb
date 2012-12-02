class AddPasswordDigest < ActiveRecord::Migration
  def up
    add_column :users, :password_digest, :string
  end

  def down
    remove_column :users, :password_digest
  end
end

#todo this can be generated with rails generate migration add_password_digest_to_users password_digest:string
