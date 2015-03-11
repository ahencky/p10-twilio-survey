class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :phone_number
      t.belongs_to :question
      t.timestamps
    end
  end
end
