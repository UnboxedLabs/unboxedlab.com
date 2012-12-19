class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :user_agent
      t.string :ip

      t.timestamps
    end
  end
end
