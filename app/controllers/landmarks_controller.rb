class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"/landmarks/index"
  end

  get '/landmarks/new' do
    erb :"/landmarks/new"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end

  post '/landmarks' do
    #this comes from the new view so create a new one
    @landmark = Landmark.create(params[:landmark])
    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end

  patch 'landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    @landmark.save

    redirect "/landmarks/#{@landmark.id}"
  end

end
