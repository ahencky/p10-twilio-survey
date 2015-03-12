# get '/' do
#     'Hello World! Currently running version ' + Twilio::VERSION + \
#         ' of the twilio-ruby library.'
# end

#  this uses the twilio-ruby helper library to generate TwiML, Twilio's Markup XML.
#  When this is deployed on heroku, need to add the URL as a get route in my twilio account settings.
#  When a participant sends a text to the twilio number, they should get the twiml text response back
#  Determine if User wants a question or is giving an answer:
  # set session['question'] when giving question
# get '/twilio-app-on-heroku' do
#     sms_sender = params[:from]
#     user_answer = params[:body]

#     current_user = Participant.find_by(phone_number: sms_sender)
#     user_id = @current_user.id
#     if session[:user_id]
#       #get their answer for the question and save it
#       question_id =session[:user_id]
#       question = Question.find(question_id)
#       user_answer = ParticipantAnswer.create(answer: user_answer)
#       question.particpant_answers << user_answer

#       message = @client.account.messages.create(:body => "Your answer was received",
#           :to => "+15103382436",
#           :from => "+15108086232")
#       puts "text message sent to: " + message.to
#     else
#       # send new question and set a session to track the question id
#       new_question = Question.create(body: "new question")
#       session[:user_id] = Question.find(new_question.id)

#       @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
#       @msg_question = new_question.body

#       # This sends me a text message with the question
#       message = @client.account.messages.create(:body => @msg_question,
#           :to => "+15103382436",
#           :from => "+15108086232")
#       puts "text message sent to: " + message.to
#     end

# end

# get '/test' do
#     @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
#     @twilio_num = ENV['TWILIO_PHONE']
#     @new_question = Question.generate_random()
#     # This sends me a text message with a random question
#     message = @client.account.messages.create(:body => @new_question.body,
#         :to => "+15103382436",
#         :from => @twilio_num)
#     puts "text message sent to: " + message.to + "from: " + @twilio_num + @new_question.body
# end

# get '/test-response' do
#     @new_question = Question.generate_random()
#     sender = params[:from]


#     twiml = Twilio::TwiML::Response.new do |r|
#       r.Message "Hi #{name} here is your question: #{@new_question.body}"
#     end
#     twiml.text
# end
