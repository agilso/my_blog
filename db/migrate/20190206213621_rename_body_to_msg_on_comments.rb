class RenameBodyToMsgOnComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :body, :msg
  end
end
