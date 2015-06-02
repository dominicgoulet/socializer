#
# Namespace for the Socializer engine
#
module Socializer
  class PeopleController < ApplicationController
    before_action :authenticate_user

    # GET /people
    def index
      @people = Person.all.decorate
    end

    # GET /people/1
    def show
      @person = find_person
    end

    # GET /people/1/edit
    def edit
      @person = current_user
    end

    # PATCH/PUT /people/1
    def update
      current_user.update!(params[:person])

      flash[:notice] = t('socializer.model.update', model: 'Person')
      redirect_to current_user
    end

    private

    def find_person
      Person.find_by(id: params[:id]).decorate
    end
  end
end
