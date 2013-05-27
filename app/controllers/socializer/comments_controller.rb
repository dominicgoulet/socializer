module Socializer
  class CommentsController < ApplicationController

    def new
      @comment = Comment.new
    end

    def create
      @comment = current_user.comments.build(params[:comment])
      @comment.activity_verb = 'add'
      # TODO: Is scope needed? Try commenting it out to see what happens
      @comment.scope = Audience.privacy_level.find_value(:public)
      @comment.save!
      redirect_to stream_path
    end

    def edit
      @comment = current_user.comments.find(params[:id])
    end

    def update
      @comment = current_user.comments.find(params[:id])
      @comment.update!(params[:comment])
      redirect_to stream_path
    end

    def destroy
      @comment = current_user.comments.find(params[:id])
      @comment.destroy
      redirect_to stream_path
    end

  end
end
