require 'sinatra'
require 'sinatra/reloader' if development?
require 'pony'

helpers do
  	def configure_pony
	  Pony.options = {
	    :via => :sendmail,
	    :via_options => { 
	      :address              => 'smtp.gmail.com', 
	      :port                 => '587',  
	      :user_name            => ENV['SENDGRID_USERNAME'], 
	      :password             => ENV['SENDGRID_PASSWORD'], 
	      :authentication       => :plain, 
	      :enable_starttls_auto => true,
	      :domain               => 'gmail.com'
	    }    
	  }
	end

end

get '/' do 
	erb :index
end


get '/home' do 
	erb :index
end

get '/about' do
	erb :about
end



post '/contact' do 
  configure_pony
  name = params[:contact_name]
  sender_email = params[:contact_email]
  message = params[:contact_message]
  logger.error params.inspect


  begin
    Pony.mail(:from => "stalin.pranava@gmail.com",
      :to => 'stalin.pranava@gmail.com', 
      :subject =>"#{name} has contacted you",
      :body => "#{message}",
      :via => :sendmail) 
    @message = "Thanks for contacting us. Email received"
    erb :contact
  rescue
    @exception = $!
    erb :index
    @message = "Mail didn't get delievered due to server issues"
  end
  
end

not_found do
	erb :not_found
end