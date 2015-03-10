class Question < ActiveRecord::Base
    belongs_to :survey
    # each participant gets only one answer to a question
    has_one :participant_answer
end
