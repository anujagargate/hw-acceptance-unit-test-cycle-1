class MoviesController < ApplicationController
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:title => :asc}, 'hilite'
    when 'director'
      ordering,@director_header = {:director => :asc}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:release_date => :asc}, 'hilite'
    end
    
    @all_ratings = Movie.all_ratings
    if !session.has_key?(:ratings) #first time app is run, select all movie ratings
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    else
      # see if ratings change was requested
      if params[:commit] == "Refresh"
        if params.has_key?(:ratings)
          #at least one rating was requested
          @selected_ratings = params[:ratings]
        else
          #no ratings are selected - cause movie list to be empty
          @selected_ratings = {}
        end
      else
        # no ratings change was requested, so just keep same ratings
        @selected_ratings = session[:ratings]
      end
    end

    session[:sort] = sort
    session[:ratings] = @selected_ratings
    
    @movies = Movie.where(rating: @selected_ratings.keys).order(ordering)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def director
    @movie = Movie.find(params[:id])
    @director = @movie.director
    
    if @director.blank?
      flash[:warning] = "'#{@movie.title}' has no director info"
      redirect_to movies_path and return
    end
    
    @movies = @movie.similar_movies
    
  end

end
