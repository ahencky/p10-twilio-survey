require 'twilio-ruby'

# get all surveys - make erb to show all surveys
get '/surveys' do
    @all_surveys = Survey.all
end

# get a specific survey - make erb for individual survey
get '/surveys/:id' do
 @survey = Survey.find(params[:id])
end

# get all questions in the survey and list them as links in erb
get 'surveys/:id/questions' do
    @questions = Survey.find(params[:id]).questions
end

# get a specific question in a specific survey - erb to show results
get 'surveys/:id/questions/:qid' do
    @question = Question.find(params[:qid])
end

# SEND an SMS survey question
get '/take-survey' do
    account_sid =ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    twilio_num = ENV['TWILIO_PHONE']
    @client = Twilio::REST::Client.new account_sid, auth_token

    # This sends a text message to the 'to' phone number from my twilio trial number
    # With the help of twilio-ruby gem it is an HTTP POST to my account's Messages list resource URI
    message = @client.account.messages.create(:body => "Twilio is sending this text message through my app",
        :to => "+15103382436",
        :from => "+15108086232")
    puts "text message sent to: " + message.to
end