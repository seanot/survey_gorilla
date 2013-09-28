get '/' do
  erb :index
end

get '/create' do
  @user = current_user
  erb :create
end

get '/logout' do
  session.clear
  erb :index
end

get '/register' do
  erb :register_new_user
end

get '/review/:id' do
  @survey = Survey.find(params[:id])
  erb :review
end

get '/survey/:id' do
  @survey = Survey.find(params[:id])
  erb :survey
end

get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  erb :results
end

get '/profile/:id' do

end


#=============POST=============

post '/review' do
  @user = current_user
  survey = Survey.create(name: params[:survey_name], user_id: @user.id)
  question = Question.create(question: params[:survey_question])
  question.choices << Choice.create(choice: params[:survey_choice_1])
  question.choices << Choice.create(choice: params[:survey_choice_2])
  question.choices << Choice.create(choice: params[:survey_choice_3])
  survey.questions << question
  redirect "/review/#{survey.id}"
end

post '/survey/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  response = Response.create(choice_id: params[:choice_id])
  redirect to ("/survey/#{@survey.id}/results")
end

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
