require 'sinatra'
require_relative 'config/application'
require 'faker'
require 'pry'

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all.order(:name)
  erb :'meetups/index'
end

get '/meetups/new' do
  if session[:user_id] == nil
    flash[:notice] = "Please sign in."
    redirect '/'
  else
    erb :'meetups/new'
  end
end


post '/meetups/new' do
  @name = params[:name]
  @errors = nil
  @location = params[:location]
  @details = params[:details]
  @meetup = Meetup.new(name: @name, location: @location, details: @details, creator_id: session[:user_id])
  if @meetup.save
    @meetup_id = Meetup.where(creator_id: session[:user_id]).last.id
    flash[:notice] = "New Meetup Created!"
    redirect 'meetups/' + @meetup_id.to_s
  else
    @meetup.valid?
    @errors = @meetup.errors.full_messages
    flash[:notice] = "Meetup Not Created"
    erb :'meetups/new'
  end
end


get '/meetups/:id' do
  @meetup = Meetup.where(id: params[:id]).first
  @users = @meetup.users
  erb :'meetups/show'
end

post '/meetups/:id' do
  @meetup_id = params[:id]
  if session[:user_id] == nil
    flash[:notice] = "Please sign in."
    redirect 'meetups/' + @meetup_id.to_s
  else
    membership = Membership.new(user_id: session[:user_id], meetup_id: @meetup_id)
    membership.save
    redirect 'meetups/' + @meetup_id.to_s
  end
end
