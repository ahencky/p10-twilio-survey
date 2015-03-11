class Question < ActiveRecord::Base
    has_many :participant_answers
    has_many :participants, through: :participant_answers
end
