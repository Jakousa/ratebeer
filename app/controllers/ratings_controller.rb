class RatingsController < ApplicationController

  # Caching with simple fragments and 1 day / delete refresh
  # Voit olettaa, että käyttäjät ovat tyytyväisiä eventual consistency -mallin mukaiseen tiedon ajantasaisuuteen.
  def index
    return if request.format.html? && fragment_exist?('ratingpage')

    @ratings = Rating.all
    @beers = Beer.top 3
    @breweries = Brewery.top 3
    @users = User.top 3
    @styles = Style.top 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    expire_fragment('ratingpage')
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
