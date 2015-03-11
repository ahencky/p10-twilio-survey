class Question < ActiveRecord::Base
    has_many :participants
    has_many :participant_answers
end
