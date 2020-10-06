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
    @user = @current_user
  end



  def update
    if params[:commit] == "Submit"
      @user = User.find(@current_user.id)
      if @user.update_attributes(image_params)
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
    if params[:commit] == "Upload picture"
      @picture = Picture.new(picture_params)
      if @picture.save
        redirect_to home_home_path, success: "You have successfully uploaded your picture."
      else
        redirect_to home_home_path, danger: "Try it again, the picture couldn't be uploaded."
      end
    elsif params[:commit] == "Like"
      likes = Like.all
      if likes.find_by(like_params) != nil
        likes.find_by(like_params).destroy
        redirect_to home_home_path, success: "You have successfully unliked #{params['like']['picture_id']}!"
      else
        like = Like.new(like_params)
        if like.save
          redirect_to home_home_path, success: "You have successfully liked #{params['like']['picture_id']}!"
        end
      end

    else params[:commit] == "create comment"
      comment = Comment.new(comment: params['comment']['comment'], user_id: @current_user.id, picture_id: params['comment']['picture_id'])
      if comment.save
        redirect_to home_home_path, success: "You have successfully posted your comment."
      else
        redirect_to home_home_path, danger: "Try it again, the comment couldn't be posted."
      end
    end
  end

  def destroy
    reset_session
    User.find(@current_user.id).destroy
    redirect_to sessions_index_path, primary: "Your account is deleted."
  end

  def default_image
    @user = User.find(@current_user.id)
    file = File.open("/home/aaron/Pictures/Screenshot from 2020-10-05 10-14-01.png")
    if @user.update_attribute(:image, file)
      redirect_to home_profile_path, success: "You have successfully set your profile picture to the default!"
    end
    file.close
  end

  def like
    like = Like.new(picture_id: params[:picture_id], user_id: @current_user.id)
    if like.save

    end
  end

  def new
    @picture = Picture.new
  end

  private

  def like_params
    params.require(:like).permit(:picture_id, :user_id)
  end

  def picture_params
    params.require(:picture).permit(:image)
  end

  def image_params
    params.require(:user).permit(:image)
  end
end
