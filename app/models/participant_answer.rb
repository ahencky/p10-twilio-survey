class ParticipantAnswer < ActiveRecord::Base
    belongs_to :question
    belongs_to :participant
end
