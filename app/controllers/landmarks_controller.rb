class LandmarksController < ApplicationController
  get '/landmarks/new' do
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    @figures = Figure.all
    erb :'/landmarks/edit'
  end

  put '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    @landmark.update(params[:landmark])
    redirect "/landmarks/#{@landmark.id}"
  end

  post '/landmarks' do
    Landmark.create(params[:landmark])
  end
end
