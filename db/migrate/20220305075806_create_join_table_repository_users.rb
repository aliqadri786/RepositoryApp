class CreateJoinTableRepositoryUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :repositories, :users do |t|
      t.index [:repository_id, :user_id]
      t.index [:user_id, :repository_id]
    end
  end
end
