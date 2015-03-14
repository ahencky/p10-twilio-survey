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
    @answers = ParticipantAnswer.where(question_id: params[:id])
    erb :result
end

post '/chart' do
    id = params[:id]
    @question = Question.find(id)
    @answers_array = ParticipantAnswer.where(question_id: id).to_a

    @answers = @answers_array.map{|user_answer| user_answer.answer.downcase.lstrip.rstrip unless user_answer.answer.nil?}
    @frequencies = {}
    @answers.map{ |answer| @frequencies[answer] = @answers.count(answer)}
    @answers.delete(nil)
    @min = @answers.min
    @max = @answers.max

    if request.xhr?
       content_type :json
      {question: @question.body, answers: @answers, frequencies: @frequencies, min: @min, max: @max}.to_json
    else
      redirect "/"
    end
end

delete '/questions/:id' do
    @question = Question.find(params[:id])
    @question.destroy()
    redirect '/'
end

get '/poll-question' do
    @sender = params[:From]

    @current_user = Participant.find_or_create_by_phone_number(phone_number: @sender)

    if session[:user_id]
        #get their response for the previous poll question
        @sender_response = params[:Body]
        @question_id = session[:question_id]

        @answer = ParticipantAnswer.create(answer: @sender_response, question_id: @question_id, participant_id: session[:user_id])
        session.clear
        twiml = Twilio::TwiML::Response.new do |r|
          r.Message "Thanks for your response. Reply to this message to get another question"
        end
        twiml.text
    else
        #send the requesting user a poll question
        @all_questions = Question.pluck(:id)
        @answered_questions = @current_user.participant_answers.pluck(:question_id)
        @unanswered_questions = @all_questions - @answered_questions
        if @unanswered_questions.empty?
            @message = "you have answered all current poll questions"
        else
            @new_question = Question.generate_random(@unanswered_questions)
            @message = @new_question.body
        end

        session[:user_id] = @current_user.id
        session[:question_id] = @new_question.id
        @current_user.questions << @new_question
        twiml = Twilio::TwiML::Response.new do |r|
          r.Message "Here is your poll question: #{@message}. Reply to this message to answer the question"
        end
        twiml.text
    end
end

get '/error' do
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "An error has occurred"
    end
    twiml.text
end