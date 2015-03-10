class SurveyResult < ActiveRecord::Base
    belongs_to :question
    belongs_to :participant
    has_many :participant_answers
    has_many :questions, through: :participant_answers
end
