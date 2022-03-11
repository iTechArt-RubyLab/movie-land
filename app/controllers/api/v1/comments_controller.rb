module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[update destroy]
      before_action :set_commentable, only: %i[create]
      before_action :authenticate_user!

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
        if @comment.update(comment_params)
          render json: @comment, serializer: CommentSerializer
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy
      end

      private

      def set_comment
        @comment = set_commentable.comments.find(params[:id])
      end

      def set_commentable
        @commentable = if params[:comment_id]
                         Comment.find(params[:comment_id])
                       elsif params[:movie_id]
                         Movie.find(params[:movie_id])
                       elsif params[:person_id]
                         Person.find(params[:person_id])
                       end
      end

      def comment_params
        params.require(:comment).permit(:body)
      end
    end
  end
end
