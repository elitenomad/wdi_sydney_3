class CommentsController < ApplicationController
	def new
		@comment = @post.comments.new
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(post_comment_params)

		if @comment.save
			redirect_to post_path(@post)
		else
			render :new
		end
	end	

	def destroy
	    @post = Post.find(params[:post_id])
	    @comment = @post.comments.find(params[:id])
	    @comment.destroy
	    redirect_to post_path(@post)
	end

	private

	def post_comment_params
		params.require(:comment).permit(:commenter,:body)
	end
end
