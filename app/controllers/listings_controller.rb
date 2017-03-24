class ListingsController < ApplicationController
  def index
    if params[:user_id] # if there is user_id
      @listings = User.find(params[:user_id]).listings # this is to show one user's all listings
    else
      @listings = Listing.all # this is to show all user's listings
    end
  end

  def show
    @listing = Listing.find(params[:id]) # find the users/user_id/listings/:id and show in show.html.erb
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params) # strong params, user can only key in the params require so hackers cannot hack
    @listing.user = current_user
    # byebug
    if @listing.save
      redirect_to @listing # redirect to controller show to show the new listing
      flash[:success] = "List successfully created!"
    else
      flash[:fail] = @listing.errors.full_messages
      render 'new' # render to 'new.html'
    end
  end

  def edit
    @listing = Listing.find(params[:id]) # find the users/user_id/listings/:id
  end

  def update
    @listing = Listing.find(params[:id]) # find the users/user_id/listings/:id
    @listing.user = current_user
    if @listing.update(listing_params) # strong params, user can only key in the params require so hackers cannot hack
      flash[:success] = "Successfully updated your listing"
      redirect_to @listing # redirect to controller show to show the new listing
    else
      flash[:error] = "Error updating lisitng"
      render 'edit' # render to controller 'edit.html'
    end
  end

  def destroy
    @listing = Listing.find(params[:id]) # find the users/user_id/listings/:id
    @listing.destroy
    redirect_to user_listings_path
  end

# strong params to prevent hacker hack into your system
private
  def listing_params
    params.require(:listing).permit(:title, :address, :pax)
  end
end
