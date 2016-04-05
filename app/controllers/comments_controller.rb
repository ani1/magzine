class CommentsController < ApplicationController
before_action :set_comment, only: [:destroy]

def new
  @comment = Comment.new(:parent_id => params[:parent_id],:article_id => params[:article_id])
end

def create
  @comment = current_user.comments.new(comment_params)
  respond_to do |format|
    if @comment.save
      @article = Article.find_by_id(params[:comment][:article_id])
      @comments = @article.comments.where(parent_id:nil).order("created_at") if @article.present?
      format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
      format.json { render :show, status: :created, location: @comment }
      format.js{}
    else
      format.html { render :new }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
      format.js{}
    end
  end
end

def destroy
  if(@comment.comments.empty? && @comment.user_id == current_user.id)
    @comment.destroy
    respond_to do |format|
      @article = Article.find_by_id(params[:article_id])
      @comments = @article.comments.where(parent_id:nil).order("created_at") if @article.present?
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  else
    render json: {error: "cannot delete"}, status: 401
  end
end

private
  def set_comment
    @comment = Comment.find(params[:id])
  end

def comment_params
  params.require(:comment).permit(:comment,:article_id,:parent_id)
end
end
