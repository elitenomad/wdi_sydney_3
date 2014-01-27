require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require 'pry'
require 'active_support/all'
require 'pg'
require 'Date'
require 'pony'
require 'sinatra/flash'


ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql',
  :host     => 'localhost',
  :username => 'pranavaswaroop',
  :database => 'happytails',
  :encoding => 'utf8'
)

require './models/shelter'
require './models/pet'

module HappyTailhelpers
	def diff_time_in_days(donated_at)
		current_time = Time.now
		donated_at = current_time if donated_at.nil?

		(current_time.to_date - ((donated_at)).to_date)
	end

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
#require './helpers/tailshelpers'

helpers HappyTailhelpers


configure do
	enable :sessions
	set :username, 'admin'
	set :password, 'admin'
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

get '/' do
	if session[:admin]
  		redirect to '/shelters'
  	else
  		session[:admin] = false
  		return erb :login
  	end
end

post '/login' do
  	if params[:username] == settings.username && params[:password] == settings.password 
		session[:admin] = true 
		session[:username] = params[:username]

		redirect to('/shelters')
    else
    	session[:admin] = false 
    	#flash[:notice] = "Please Enter valid credentials..."
    	erb :login
	end
end

get '/logout' do
  session.clear
  redirect to('/')
end


get '/new' do
	erb :new
end


post '/create' do
	#now = Time.now
	c=nil
	c = Shelter.create(params.merge(capacity:params[:tot_capacity]))
	if c.valid?
		redirect to '/shelters'
	else
		@shelter = c
		erb :new
	end
end

get '/shelters' do
	@shelters = Shelter.all
	erb :home
end

get '/shelters/:id' do
  	@shelter = Shelter.find(params[:id])

  	if params[:sort].nil? || params[:sort].empty?
  		@pets = @shelter.pets.where("adopted=false or adopted is null").order("donated_at")
  	else
  		@pets = @shelter.pets.where("adopted=false or adopted is null").order("#{params[:sort]}")
  	end

  	erb :show
end

post '/shelters/:id' do
	@shelter = Shelter.find("#{params[:id]}")

	erb :edit
end	


put '/shelters/:id' do
	#now = Time.now
	c=nil
	c = Shelter.find(params[:id])
	c.update_attributes(name: params[:name],description:"#{params[:description]}",
		location:"#{params[:location]}",tot_capacity:"#{params[:tot_capacity]}")
	
	if c.valid?
		redirect to '/shelters'
	else
		@blog = c
		erb :edit
	end
end	


delete '/shelters/:id' do
	shelter = Shelter.find(params[:id])
	shelter.destroy

	redirect to '/shelters'
end


get '/shelters/:id/pets/new' do
	@shelter = Shelter.find(params[:id])
	erb :pets_new
end

post '/shelters/:id/pets/create' do
	id = params[:id]
	@shelter = Shelter.find(id)

	if (@shelter.pets.where(adopted: false).count == @shelter['tot_capacity'])
		full_shelters = Shelter.select(:name).where("capacity > 0")
		flash[:notice] = "Capacity of the shelter exceeded.Please look out for other shelters #{full_shelters.map{|f| f['name']}}"
		redirect to "/shelters/#{id}"
	end

	@created = @shelter.pets.create(name:params[:name], spieces:params[:spieces], breed: params[:breed],
						age:params[:age],image_url:params[:image_url],donated_at:params[:donated_at],
						donated: true,adopted:false)
	

	if @created.valid?
		pets = @shelter.pets.where(adopted: false).count
		updated_count = @shelter['tot_capacity'] - pets
		@shelter.update(capacity: updated_count)
		flash[:notice] = "Successfully Created a pet row in database"
	else
		#flash[:notice] = "Please contact Service desk..."
		#redirect to "/shelters/#{id}"
		return erb :pets_new
	end
	
	redirect to "/shelters/#{id}"
	
end


get '/shelters/:id/pets/:pet_id/adopt' do
	@shelter = Shelter.find(params[:id])

	pet = @shelter.pets.find(params[:pet_id])
	adopt = pet.update_attributes(adopted:true, adopted_at: Time.now)
	binding.pry
	if adopt
		pets = @shelter['capacity'] #.pets("where adopted=false").count
		updated_count =  pets+1#@shelter['tot_capacity'] - pets
		@shelter.update(capacity: updated_count)
		flash[:notice] = "Pet Successfully adopted"
	end

	@pets = @shelter.pets.all
	redirect to "/shelters/#{params[:id]}"
end


get '/shelters/:id/adopted' do
	@shelter = Shelter.find(params[:id])

	@pets = @shelter.pets.where("adopted=true").order("adopted_at desc")
	
	erb :pets_past
end


get '/shelters/:id/filter' do
	@shelter = Shelter.find(params[:id])

	if(params[:filter] == 'spieces')
		@pets = @shelter.pets.where("spieces = '#{params[:spieces]}' ")
	elsif (params[:filter] == 'age')
		@pets = @shelter.pets.where("age #{params[:relation]} #{params[:age]} ")
	end

	erb :filter
end












