class Survey < ActiveRecord::Base
    has_many :questions, dependent: :destroy
    has_many :survey_results
    has_many :participants, through: :survey_results
end
