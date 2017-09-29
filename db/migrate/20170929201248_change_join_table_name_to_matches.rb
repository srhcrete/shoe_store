class ChangeJoinTableNameToMatches < ActiveRecord::Migration[5.1]
  def change
    rename_table :match_join, :matches
  end
end
