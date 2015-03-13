class Question < ActiveRecord::Base
    has_many :participant_answers
    has_many :participants, through: :participant_answers

    def self.generate_random(question_ids)
        return self.find(question_ids.sample(1)[0])
    end
end
