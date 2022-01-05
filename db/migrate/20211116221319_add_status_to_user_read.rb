class AddStatusToUserRead < ActiveRecord::Migration[5.2]
  def change
    add_column :user_reads, :status, :string
  end
end
