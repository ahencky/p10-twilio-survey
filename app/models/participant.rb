class Participant < ActiveRecord::Base
    has_many :participant_answers
    has_many :questions
end
