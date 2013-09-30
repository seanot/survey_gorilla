get '/' do
  erb :index
end

get '/create' do
  if current_user
    @user = current_user
  end
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

get '/add_question/:id' do
  @user = current_user
  @survey = Survey.find(params[:id])
  erb :create_add
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
  @user = User.find(params[:id])
  puts @user.authored_surveys
  @photo = Photo.find_by(user_id: @user.id)
  erb :profile
end

get '/profile/:id/edit' do
  @user = User.find(params[:id])
  @photo = Photo.find_by(user_id: @user.id)
  erb :edit_photo , layout: !request.xhr?
end


#=============POST=============

post '/profile/:id/upload' do
  @user = current_user
  @photo = Photo.create(file: params[:image], user_id: @user.id)
  redirect "/profile/#{@user.id}"
end

post '/profile/:id/edit/:photo_id' do
  @user = current_user
  @photo = Photo.find(params[:photo_id])
  @photo.update_attributes(file: params[:image])
  redirect "/profile/#{@user.id}"

end

post '/review' do
  @user = current_user
  @survey = Survey.create(name: params[:survey_name])
  @survey.update_attributes(user_id: @user.id)
  @survey.save
  question = Question.create(question: params[:survey_question])
  question.choices << Choice.create(choice: params[:survey_choice_1])
  question.choices << Choice.create(choice: params[:survey_choice_2])
  question.choices << Choice.create(choice: params[:survey_choice_3])
  @survey.questions << question
  
  redirect "/review/#{@survey.id}"
end

post '/review_add/:id' do
  @user = current_user
  @survey = Survey.find(params[:id])
  unless @survey.name == params[:survey_name]
    @survey.update_attributes(name: params[:survey_name])
    @survey.save
  end
  question = Question.create(question: params[:survey_question])
  question.choices << Choice.create(choice: params[:survey_choice_1])
  question.choices << Choice.create(choice: params[:survey_choice_2])
  question.choices << Choice.create(choice: params[:survey_choice_3])
  @survey.questions << question

  redirect "/review/#{@survey.id}"
end

post '/survey/:survey_id/results' do
  @survey = Survey.find(params[:survey_id])
  @survey.questions.each do |question|
    Response.create(choice_id: params[:"#{question.id}"].to_i)
  end
  redirect to ("/survey/#{@survey.id}/results")
end

post '/register' do
  @user = User.new(email: params[:email])
  @user.password = params[:password]
  if @user.save
    session[:user_id] = @user.id
  end
  redirect "/profile/#{@user.id}"
end

post '/login' do
  email = params[:email]
  password = params[:password]
  @user = User.authentication(email, password)
  if @user
    session[:user_id] = @user.id
    redirect "/profile/#{@user.id}"
  else
    @error = "email or password invalid"
    redirect "/"
  end
end

