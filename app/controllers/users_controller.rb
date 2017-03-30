class UsersController < Clearance::UsersController
  def index
    @user = User.all.page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user = current_user
    # byebug
    if @user.update(user_params)
      flash[:success] = "Successfully updated your profile"
      redirect_to @user
    else
      flash[:error] = "Error updating profile"
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :photo)
    end
end
