class Participant < ActiveRecord::Base
    has_many :survey_results
    has_many :surveys, through: :survey_results
end
