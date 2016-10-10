class AdminsController < ApplicationController
  # before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :check_admin, :register

  def index
  end

  def users
    @users = User.all
  end

  def posts
    @posts = Post.all.order('created_at DESC')
  end

  def history
    @history = History.limit(10).order('created_at DESC')
  end

  def clear_history
    @history = History.destroy_all
    redirect_to action: "history"
  end

  private

    def register
      History.register(user_id: current_user.id, action: action_name)
    end

end
