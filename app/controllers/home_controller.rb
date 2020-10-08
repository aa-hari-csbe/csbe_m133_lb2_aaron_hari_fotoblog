class HomeController < ApplicationController

  # Is called when ever the home site is accessed.
  # Provides date for the home site to render.
  def home
    @pictures = Picture.all
    @comments = Comment.all
    @likes = Like.all
    @users = User.all
    @picture = Picture.new
  end

  # Is called when ever the profile site is accessed.
  def profile
    @users = User.all
    @user = @current_user
  end

  # Contains function to delete a account,
  # and to reset a profile picture.
  def update
    if params[:commit] == "Delete account"
      reset_session
      User.find(@current_user.id).destroy
      redirect_to sessions_index_path, primary: "Your account is deleted."
    elsif params[:commit] == "Reset image"
      # Creates a new user using the passed parameters.
      @user = User.find(@current_user.id)
      file = File.open(@@default_profile_picture_path)
      if @user.update_attribute(:image, file)
        redirect_to home_profile_path, success: "You have successfully set your profile picture to the default!"
      end
      file.close
      # If the user hasn't uploaded a profile picture,
      # it gets set to the default image.
    elsif params['user']['image'] == nil
      @user = User.find(params['user']['id'])
      @user.update_attributes(username: params['user']['username'], firstname: params['user']['firstname'], lastname: params['user']['lastname'])
      redirect_to home_home_path, success: "You have successfully updated your profile!"
      # If the user has uploaded a profile picture it gets saved now.
    else
      @user = User.find(params['user']['id'])
      @user.update_attributes(username: params['user']['username'], firstname: params['user']['firstname'], lastname: params['user']['lastname'], image: params['user']['image'])
      redirect_to home_home_path, success: "You have successfully updated your profile!"
    end
  end

  # Contains function to upload a picture, like a picture,
  # unlike a picture, and create a new comment.
  def create
    if params[:commit] == "Upload picture"
      @picture = Picture.new(picture_params)
      # Checks if the picture can be saved,
      # and if so, it does that.
      if @picture.save
        redirect_to home_home_path, success: "You have successfully uploaded your picture."
      else
        redirect_to home_home_path, danger: "Try it again, the picture couldn't be uploaded."
      end

    elsif params[:commit] == "Like"
      like = Like.new(like_params)
      # Checks if the like can be saved,
      # and if so, it does that.
      if like.save
        redirect_to home_home_path, success: "You have successfully liked #{params['like']['picture_id']}!"
      end

    elsif params[:commit] == "Unlike"
      likes = Like.all
      # Picks the like based of the parameters and deletes(destroys) it.
      likes.find_by(like_params).destroy
      redirect_to home_home_path, success: "You have successfully unliked #{params['like']['picture_id']}!"

    else
      params[:commit] == "create comment"
      comment = Comment.new(comment: params['comment']['comment'], user_id: @current_user.id, picture_id: params['comment']['picture_id'])
      # Checks if the comment can be saved,
      # and if so, it does that.
      if comment.save
        redirect_to home_home_path, success: "You have successfully posted your comment."
      else
        # If the comment couldn't be saved it creates a flash warning.
        redirect_to home_home_path, danger: "Try it again, the comment couldn't be posted."
      end
    end
  end


  private

  # Defines the parameters for a like.
  def like_params
    params.require(:like).permit(:picture_id, :user_id)
  end

  # Defines the parameters for a picture (model: picture).
  def picture_params
    params.require(:picture).permit(:image)
  end

  # Defines the parameters for a image (model: user).
  def image_params
    params.require(:user).permit(:image)
  end
end
