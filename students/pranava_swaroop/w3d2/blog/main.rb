require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?
require 'pry'
require 'active_support/all'
require 'pg'


ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql',
  :host     => 'localhost',
  :username => 'pranavaswaroop',
  :database => 'blog',
  :encoding => 'utf8'
)


class Blog < ActiveRecord::Base
	has_many :comments

	validates :title, presence: true 
	validates :title, uniqueness: true
	validates :title, length:{ in: 5..255 }

	validates :author, presence: true
end

class Comment < ActiveRecord::Base
	belongs_to :post
	validates :comment, presence: true
	validates :comment, length: { maximum: 500 }

	validates :author, presence: true
end

#binding.pry

configure do
	enable :sessions
	set :username, 'admin'
	set :password, 'admin'
end


get '/' do
	if session[:admin]
  		redirect to '/posts'
  	else
  		session[:admin] = false
  		return erb :login
  	end
end

post '/login' do
  	if params[:username] == settings.username && params[:password] == settings.password 
		session[:admin] = true 
		session[:username] = params[:username]

		redirect to('/posts')
    else
    	session[:admin] = false 
    	erb :login
	end
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/posts/?:id?' do
	n = params[:sort]
	puts "what is n  : #{n}"
	#@blogs = Blog.order("#{n}").reverse

	if n.nil? || n.empty?
		@blogs = Blog.order("created_at desc")
	else
		if n=='updated_at'
			@blogs = Blog.order("#{n} desc")
		else
			@blogs = Blog.order("#{n}")
		end
	end

	erb :home
end


get '/new' do
	erb :new
end


post '/create' do
	now = Time.now
	c=nil
	c = Blog.create(params.merge(created_at: now))
	if c.valid?
		redirect to '/posts'
	else
		@blog = c
		erb :new
	end
end


get '/posts/:id/show' do
	@blog = Blog.find("#{params[:id]}")
	@comments = Comment.where(blog_id:"#{params[:id]}")
	erb :show
end

post '/posts/:id/edit' do
	@blog = Blog.find("#{params[:id]}")

	erb :edit
end	

put '/posts/:id/update' do
	now = Time.now
	c=nil
	c = Blog.find(params[:id])
	c.update_attributes(title:"#{params[:title]}",description:"#{params[:description]}",
		bodydesc:"#{params[:bodydesc]}",author:"#{params[:author]}",updated_at:"#{now}")
	
	if c.valid?
		redirect to '/posts'
	else
		@blog = c
		erb :edit
	end
end	


delete '/posts/:id/destroy' do
	comments = Comment.find_by(blog_id:"#{params[:id]}")
	comments.destroy if !comments.nil?
	Blog.delete("#{params[:id]}")

	redirect to '/posts'
end

get '/gallery' do
	@rows = Blog.select("author, count(*)").group("author")
	erb :gallery
end


post '/posts/:id/comment/create' do
	now = Time.now
	Comment.create(comment:"#{params[:comment]}",
							author:"#{params[:author]}",
							created_at:"#{now}",blog_id:"#{params[:id]}")

	
	redirect to "/posts/#{params[:id]}/show"
end

get '/posts/:id/comment/:comment_id/delete' do
	comment = Comment.find(params[:comment_id])
	comment.destroy
	redirect to "/posts/#{params[:id]}/show"
end




def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
end


























