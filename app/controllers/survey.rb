require 'twilio-ruby'

get "/" do
    @questions = Question.all
    erb :index
end

# form to make a new poll question
get '/questions/new' do

    erb :new_question
end

# new question form posts here
post '/questions' do
    @input_question = params[:question]
    @new_question = Question.create(body: @input_question)
    redirect '/'
end

# get polling results for a specific question
get '/questions/:id' do
    @question = Question.find(params[:id])
    erb :question
end

# GET request URL when user texts my twilio number. Sends a poll question back as a text message
get '/take-survey' do
    account_sid =ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    @twilio_num = ENV['TWILIO_PHONE']
    @client = Twilio::REST::Client.new account_sid, auth_token

    # Find the user by their phone number
    @user_phone = params[:From]
    @participant = Participant.where(phone_number: @user_phone).first || Participant.create(phone_number: @user_phone)

    # Reply to the user with a question
    # answered_questions_ids= @participant.questions.pluck(:question_id) # returns array of ids

    @new_question = Question.generate_random() # for now just get a random question

    # This sends a text message to the 'to' phone number from my twilio trial number
    # With the help of twilio-ruby gem it is an HTTP POST to my account's Messages list resource URI
    message = @client.account.messages.create(:body => @new_question.body,
        :to => @user_phone,
        :from => @twilio_num)
    puts "text message sent to: " + message.to + @new_question.body
end

get '/test-response' do
    @new_question = Question.generate_random()
    sender = params[:from]

    sender_msg = params[:body]

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Hi #{sender} here is your question: #{@new_question.body}"
    end
    twiml.text
end