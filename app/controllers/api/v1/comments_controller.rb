module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_commentable

      def create
        @comment = @commentable.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
          render json: @comment, status: :created, serializer: CommentSerializer
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def update
        if @commentable.update(comment_params)
          render json: @commentable, serializer: CommentSerializer
        else
          render json: @commentable.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @commentable.destroy
      end

      private

      def set_commentable
        @commentable = Comment.find_by(id: params[:comment_id]) if params[:comment_id]
        @commentable = Movie.find_by(id: params[:movie_id]) if params[:movie_id]
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
