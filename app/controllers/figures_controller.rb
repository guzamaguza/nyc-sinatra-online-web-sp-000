class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    #find figure you want to edit
    @figure = Figure.find(params[:id])
    #load up all titles
    @titles = Title.all
    #load up all landmarks
    @landmarks = Landmark.all

    erb :'/figures/edit'
  end

  post '/figures' do
    binding.pry
    #create a new figure using params inputs
    @figure = Figure.create(params[:figure])
    #if the user put a new title then add it to the figure
    if !params([:title][:name]).empty?
      @figure.titles << Title.create(params[:title])
    end
    #if the user put a new landmark/year then add it to the figure
    if !params([:landmark][:name]).empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    #save the figure to the db
    @figure.save

    redirect :"/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    #find the figure you will be editing
    @figure = Figure.find(params[:id])
    #update the figure
    @figure.update(params[:figure])
    #if the title field was filled out then update the title
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    #if the landmark field was filled out then update it
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save

    redirect :"/figures/#{@figure.id}"
  end

end
