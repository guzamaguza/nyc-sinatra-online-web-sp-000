class FiguresController < ApplicationController
  # add controller methods
  class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  post '/figures' do
    # Create new figure from params
    @figure = Figure.create(params[:figure])

    # if there is a new title, add it to titles & figure
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])     
    end

    # if there is a new landmark/year, add it to landmarks & figure
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])      
    end

    # save to database!
    @figure.save

    redirect :"/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    # Find figure by id
    @figure = Figure.find(params[:id])
   
    # Update figure
    @figure.update(params[:figure])

    # check for new title
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    # check for new landmark
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    # save
    @figure.save

    redirect "/figures/#{@figure.id}"
  end

end
end
