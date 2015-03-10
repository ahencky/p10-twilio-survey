class ParticipantAnswer < ActiveRecord::Base
    belongs_to :question
    belongs_to :survey_result
end
