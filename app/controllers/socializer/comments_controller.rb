# frozen_string_literal: true
#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Comments controller
  #
  class CommentsController < ApplicationController
    before_action :authenticate_user

    # GET /comments/new
    def new
      respond_to do |format|
        format.html { render :new, locals: { comment: Comment.new } }
      end
    end

    # POST /comments
    def create
      current_user.comments.create!(params[:comment]) do |comment|
        comment.activity_verb = "add"
        comment.scope = Audience.privacy.find_value(:public)
      end

      flash[:notice] = t("socializer.model.create", model: "Comment")
      redirect_to activities_path
    end

    # GET /comments/1/edit
    def edit
      respond_to do |format|
        format.html { render :edit, locals: { comment: find_comment } }
      end
    end

    # PATCH/PUT /comments/1
    def update
      comment = find_comment
      comment.update!(params[:comment])

      flash[:notice] = t("socializer.model.update", model: "Comment")
      redirect_to activities_path
    end

    # DELETE /comments/1
    def destroy
      comment = find_comment
      comment.destroy
      redirect_to activities_path
    end

    private

    def find_comment
      @find_comment ||= current_user.comments.find_by(id: params[:id])
    end
  end
end
