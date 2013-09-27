get '/' do
  erb :index
end

get '/logout' do
  session.clear
  erb :index
end

get '/register' do
  erb :register_new_user
end



#=============POST=============

post '/register' do
  @user = User.new(email: params[:email])
  @user.password = params[:password]
  if @user.save
    session[:user_id] = @user.id
  end
  
  redirect "/"
end

post '/login' do
  email = params[:email]
  password = params[:password]
  @user = User.authentication(email, password)
  session[:user_id] = @user.id
  
  redirect "/profile/#{@user.id}"

end
