get '/' do
    'Hello World! Currently running version ' + Twilio::VERSION + \
        ' of the twilio-ruby library.'
end

get '/sms-quickstart' do
  twiml = Twilio::TwiML::Response.new do |r|
    r.Message "Hey Monkey. Thanks for the message!"
  end
  twiml.text
end

get '/test' do
    # This sends me a text message

    @client = Twilio::REST::Client.new account_sid, auth_token

    message = @client.account.messages.create(:body => "Twilio is sending this text message through my app",
        :to => "+15103382436",
        :from => "+15108086232")
    puts "text message sent to: " + message.to
end
