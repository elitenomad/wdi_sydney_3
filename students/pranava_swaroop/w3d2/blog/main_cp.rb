require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'active_support/all'
require 'pg'

configure do
	enable :sessions
	set :username, 'admin'
	set :password, 'admin'
end


helpers do
	def run_sql(sql)
		#connect to cats db
		conn = PG.connect(:dbname => 'blog', :host => 'localhost')
		# exec the sql in the argument
		res = conn.exec(sql)
		# close the db connection
		conn.close
		# return the result of the sql
		res
	end

	def self.escape_characters_in_string(string)
	    pattern = /(\'|\"|\.|\*|\/|\-|\\)/
	    string.gsub(pattern){|match|"\\"  + match}
	end
end

get '/' do
  erb :login
end

post '/login' do
  	if params[:username] == settings.username && params[:password] == settings.password 
		session[:admin] = true 
		session[:username] = params[:username]

		redirect to('/posts')
    else
    	erb :login
	end
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/posts' do
	n = params[:sort]
	if n.nil? || n.empty?
		sql ="SELECT * FROM blog order by created_at desc"
	else
		if n=='updated_at'
			sql = "SELECT * FROM blog order by #{n} desc"
		else
			sql = "SELECT * FROM blog order by #{n}"
		end
	end

	@blogs = run_sql(sql)

	erb :home
end

get '/posts/:id' do
	sql = "SELECT * from blog where id='#{params[:id]}'"
	res = run_sql(sql)
	@blog = res[0]

	@comments = run_sql("SELECT * from comments where blog_id=#{params[:id]}")
	erb :show
end

get '/new' do
	#halt(401,'Not Authorized') unless session[:admin]
	erb :new
end


post '/create' do
	now = Time.now
	sql = "INSERT INTO BLOG (title,description,bodydesc,author,created_at) values('#{params[:title]}',
			'#{params[:description]}','#{params[:bodydesc]}','#{params[:author]}','#{now}')"
	
	run_sql(sql)

	redirect to '/posts'
end


post '/posts/:id/edit' do
	sql = "SELECT * from blog where id='#{params[:id]}'"
	res = run_sql(sql)
	@blog = res[0]

	

	erb :edit
end	

put '/posts/:id/update' do
	now = Time.now
	sql = "UPDATE BLOG set title='#{params[:title]}',description='#{params[:description]}'
			,bodydesc='#{params[:bodydesc]}',author='#{params[:author]}',updated_at='#{now}' 
			where id='#{params[:id]}'"
	res = run_sql(sql)
	
	redirect to '/posts'
end	

delete '/posts/:id/destroy' do
	run_sql("DELETE FROM COMMENTS where blog_id=#{params[:id]}")
	sql = "DELETE  from blog where id=#{params[:id]}"
	res = run_sql(sql)

	redirect to '/posts'
end

get '/gallery' do
	sql = "select author,count(*) from blog group by author"
	@rows = run_sql(sql)

	erb :gallery
end


post '/posts/:id/comment/create' do
	now = Time.now
	sql = "INSERT INTO COMMENTS (comment,author,created_at,blog_id) values 
			('#{params[:comment]}','#{params[:author]}','#{now}','#{params[:id]}')"

	run_sql(sql)

	redirect to "/posts/#{params[:id]}"
end

get '/posts/:id/comment/:comment_id/delete' do
	sql = "DELETE FROM COMMENTS where blog_id=#{params[:id]} and id=#{params[:comment_id]}"

	run_sql(sql)

	redirect to "/posts/#{params[:id]}"
end

	