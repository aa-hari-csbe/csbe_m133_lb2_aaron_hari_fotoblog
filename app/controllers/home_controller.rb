class HomeController < ApplicationController

  def home
    @pictures = Picture.all
    @comments = Comment.all
    @likes = Like.all
    @users = User.all
  end

  def create_comment

  end

  def determine
    render json: {status: "Its determining"}
  end

end
