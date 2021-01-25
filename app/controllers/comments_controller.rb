class CommentsController < ApplicationController

  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to article_path(article), notice: 'コメントしました'
    else
      flash.now[:error] = 'コメントできません...'
      render :new
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end