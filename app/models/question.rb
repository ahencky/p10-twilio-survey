class Question < ActiveRecord::Base
    has_many :participant_answers
    has_many :participants, through: :participant_answers

    def self.generate_random
        ids = self.pluck(:id)
        return self.find(ids.sample(1)[0])
    end
end
