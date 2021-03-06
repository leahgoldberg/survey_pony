get "/surveys" do
  @surveys = Survey.limit(25).order(updated_at: :desc)
  erb :"surveys/index"
end

get "/surveys/new" do
  @survey = Survey.new
  erb :"surveys/new"
end

get "/surveys/:id" do
  @survey = Survey.find_by(id: params[:id])
  erb :"surveys/show"
end

post "/surveys" do
  @survey = current_user.created_surveys.build(params[:survey])
  if @survey.save
    if request.xhr?
      erb :'questions/_first', layout: false, locals: {survey: @survey}
    else
      redirect "/surveys/#{survey.id}/questions/new"
    end
  else
    flash[:error] = ['You need a title and a category!']
    redirect "/surveys/new"
  end
end

get "/surveys/:id/edit" do
  @survey = Survey.find_by(id: params[:id])
  redirect "/" unless authorized?(@survey.creator.id)
  erb :'surveys/edit'
end

put "/surveys/:id" do
	survey = Survey.find_by(id: params[:id])
	survey.update_attributes(params[:survey])
	redirect "/questions/#{survey.questions.first.id}/edit"
end

delete "/surveys/:id" do
  survey = Survey.find_by(id: params[:id])
  survey.destroy
  redirect "/users/#{current_user.id}"
end
