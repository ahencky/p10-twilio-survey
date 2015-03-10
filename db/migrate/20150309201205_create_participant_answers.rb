class CreateParticipantAnswers < ActiveRecord::Migration
  def change
    create_table :participant_answers do |t|
      t.text :answer
      t.belongs_to :question
      t.belongs_to :survey_result
      t.timestamps
    end
  end
end
