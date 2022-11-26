class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = current_user
    @posts = Post.group_em(policy_scope(Post).reverse, 4)
  end
end
