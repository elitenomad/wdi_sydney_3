require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'active_support/all'
require 'pg'

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
end

get '/' do 
	sql ="SELECT * FROM blog"
	@blogs = run_sql(sql)

	erb :home
end

get '/posts/:id' do
	sql = "SELECT * from blog where id='#{params[:id]}'"
	res = run_sql(sql)
	@blog = res[0]

	erb :show
end

get '/new' do

	erb :new
end


post '/create' do
	now = Time.now
	sql = "INSERT INTO BLOG (title,description,bodydesc,author,created_at) values('#{params[:title]}',
			'#{params[:description]}','#{params[:bodydesc]}','#{params[:author]}','#{now}')"
	
	run_sql(sql)

	redirect to '/'
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
			,bodydesc='#{params[:bodydesc]}',author='#{params[:author]}',created_at='#{now}' 
			where id='#{params[:id]}'"
	res = run_sql(sql)
	
	redirect to '/'
end	

delete '/posts/:id/destroy' do
	sql = "DELETE  from blog where id=#{params[:id]}"
	res = run_sql(sql)

	redirect to '/'
end

	