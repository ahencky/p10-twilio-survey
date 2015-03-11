class CreateParticipantAnswers < ActiveRecord::Migration
  def change
    create_table :participant_answers do |t|
      t.text :answer
      t.belongs_to :question, index:true
      t.belongs_to :participant, index:true
      t.timestamps
    end
  end
end
