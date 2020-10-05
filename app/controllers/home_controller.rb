class HomeController < ApplicationController

  def home
    @pictures = Picture.all
    @comments = Comment.all
    @likes = Like.all
    @users = User.all
    @picture = Picture.new
  end




  def profile
    @users = User.all
  end



  def update
    if params[:commit] == "Submit"
      @user = User.find(@current_user.id)
      @user.update_attribute(:image, image_params)
      if @user.save
        redirect_to home_profile_path, success: "You have successfully uploaded your image!"
      else
        redirect_to home_profile_path, danger: "Try it again, the picture couldn't be updated."
      end
    else
      @user = User.find(params['user']['id'])
      @user.update_attributes(username: params['user']['username'], firstname: params['user']['firstname'], lastname: params['user']['lastname'])
      redirect_to home_home_path, success: "You have successfully updated your profile!"
    end
  end





  def create
    if params[:commit] == "create_comment"
      comment = Comment.new(comment: params['comment']['comment'], user_id: @current_user.id, picture_id: params['comment']['picture_id'])
      if comment.save
        redirect_to home_home_path, success: "You have successfully posted your comment."
      else
        redirect_to home_home_path, danger: "Try it again, the comment couldn't be posted."
      end
    else
      @picture = Picture.new(picture_params)
      if @picture.save
        redirect_to home_home_path, success: "You have successfully uploaded your picture."
      else
        redirect_to home_home_path, danger: "Try it again, the picture couldn't be uploaded."
      end
    end
  end

  #////////////////////

  def new
    @picture = Picture.new
  end

  private

  def picture_params
    params.require(:picture).permit(:image)
  end

  def image_params
    params.require(:user).permit(:image)
  end
end
