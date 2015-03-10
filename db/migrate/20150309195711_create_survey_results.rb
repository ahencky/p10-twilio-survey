class CreateSurveyResults < ActiveRecord::Migration
  def change
    create_table :survey_results do |t|
        t.belongs_to :participant
        t.belongs_to :survey
        t.belongs_to :participant_answer
        t.integer :for_question
        t.datetime :result_date
        t.timestamps
    end
  end
end
