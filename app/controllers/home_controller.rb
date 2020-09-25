class HomeController < ApplicationController

  def home
    @pictures = Picture.all
    @comments = Comment.all
    @likes = Like.all
    @users = User.all
  end

end
