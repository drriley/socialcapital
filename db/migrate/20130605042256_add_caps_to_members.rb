class AddCapsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :caps, :integer
  end
end
