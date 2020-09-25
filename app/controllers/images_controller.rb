class ImagesController < ApplicationController
  def image
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(post_params)
    @user.save
    redirect_to home_profile_path, success: "You have successfully uploaded your image!"
  end

  private

  def post_params
    params.require(:user).permit(:image)
  end

end
