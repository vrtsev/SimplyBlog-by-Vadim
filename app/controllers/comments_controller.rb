class CommentsController < ApplicationController
  def create
    @post = find_post
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Ваш комментарий был опубликован'
    else
      flash[:failure] = 'Ошибка. Проверьте правильность заполнения формы'
    end
    redirect_to post_path(@post)
  end

  def edit
    @post = find_post
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = find_post
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'Ваш комментарий был обновлен'
      redirect_to post_path(@post)
    else
      flash[:failure] = 'Ошибка. Проверьте правильность заполнения формы'
      render :edit
    end
  end

  def destroy
    @post = find_post
    @comment = @post.comments.find(params[:id])
    return unless @comment.user == current_user

    if @comment.destroy
      flash[:success] = 'Ваш комментарий был удален'
    else
      flash[:failure] = 'Произошла ошибка. Повторите попытку'
    end
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = current_user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
