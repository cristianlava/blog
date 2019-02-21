require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get "/" do
    erb :welcome
  end

  get '/blogs' do
    @blogs = Blog.all
    erb :index
  end

  get '/blogs/new' do
    erb :new
  end

  post '/blogs' do
    @blog = Blog.create(params)
    redirect to "/blogs/#{@blog.id}"
  end

  get '/blogs/:id' do
    @blogs = Blog.find_by_id(params[:id])
    erb :show
  end

  get '/blogs/:id/edit' do
    @blogs = Blog.find_by_id(params[:id])
    erb :edit
  end

  patch '/blogs/:id' do
    @blogs = Blog.find_by_id(params[:id])
    @blogs.title = params[:title]
    @blogs.content = params[:content]
    @blogs.author = params[:author]
    @blogs.save
    redirect to "/blogs/#{@blogs.id}"
  end

  get '/blogs/:id/delete' do
    @blogs = Blog.find_by_id(params[:id])
    erb :delete
  end

  delete "/blogs/:id" do
    @blogs = Blog.find_by_id(params[:id])
    @blogs.delete
    redirect to '/blogs'
  end
  

end
