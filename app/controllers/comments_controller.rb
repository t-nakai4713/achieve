class CommentsController < ApplicationController
 before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog

    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @blog = @comment.blog
  end

  def update
    @comment.update(comment_params)
      if @comment.save
        redirect_to blog_path(@comment.blog), notice: 'コメントを編集しました。' 
      else
        render :edit 
      end
    end

  def destroy
    @blog = @comment.blog
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end


  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

   def set_comment
     @comment = Comment.find(params[:id])
   end
end
