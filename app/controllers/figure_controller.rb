class FiguresController < Sinatra::Base

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
    @landmarks = @figure.landmarks
    @titles = @figure.titles
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  put '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = []
    @landmarks = []
    if params[:figure][:title_ids]
      params[:figure][:title_ids].map do |title_id|
        @titles << Title.find(title_id)
      end
    end
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].map do |landmark_id|
        @landmarks << Landmark.find(landmark_id)
      end
    end

    if params[:landmark][:name]
      @landmarks << Landmark.create(name: params[:landmark][:name])
    end
    if params[:title][:name]
      @titles << Title.create(name: params[:title][:name])
    end

    @figure.update(name: params[:figure][:name], titles: @titles, landmarks: @landmarks)
    redirect "/figures/#{params[:id]}"
  end

  post '/figures' do
    @new_figure =  Figure.create(name: params[:figure][:name])
    if params[:figure][:title_ids]
      @titles = params[:figure][:title_ids].map do |title_id|
        @new_figure.titles << Title.find(title_id)
      end
      @new_figure.save
    end
    if params[:figure][:landmark_ids]
      @landmarks = params[:figure][:landmark_ids].map do |landmark_id|
        @new_figure.landmarks << Landmark.find(landmark_id)
      end
      @new_figure.save
    end
    if params[:landmark][:name]
      @new_figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end
    if params[:title][:name]
      @new_figure.titles << Title.create(name: params[:title][:name])
    end
  end
end
