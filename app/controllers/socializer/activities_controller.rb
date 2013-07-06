module Socializer
  class ActivitiesController < ApplicationController

    def index
      @activities = Activity.stream(provider: params[:provider], actor_id: params[:id], viewer_id: current_user.id)
      @current_id = nil
      if params[:provider] == 'circles'
        @circle = Circle.find(params[:id])
        @title = @circle.name
        @current_id = @circle.guid
      elsif params[:provider] == 'people'
        @person = Person.find(params[:id])
        @title = @person.display_name
        @current_id = @person.guid
      elsif params[:provider] == 'groups'
        @group = Group.find(params[:id])
        @title = @group.name
        @current_id = @group.guid
      else
        @title = "Activity stream"
      end
    end

    def audience
      activities = Activity.stream(provider: 'activities', actor_id: params[:id], viewer_id: current_user.id)

      @object_ids = []
      is_public = false

      activities.each do |activity|
        activity.audiences.each do |audience|
          # In case of CIRCLES audience, add each contacts of every circles
          # of the actor of the activity.
          if audience.privacy_level.public?
            @object_ids.push audience.privacy_level
            is_public = true
          elsif audience.privacy_level.circles?
            activity.actor.circles.each do |circle|
              circle.activity_contacts.each do |contact|
                @object_ids.push contact
              end
            end
          else
            if audience.activity_object.activitable_type == 'Socializer::Circle'
              # In the case of LIMITED audience, then go through all the audience
              # circles and add contacts from those circles in the list of allowed
              # audience.
              audience.activity_object.activitable.activity_contacts.each do |contact|
                @object_ids.push contact
              end
            else
              # Otherwise, the target audience is either a group or a person,
              # which means we can add it as it is in the audience list.
              @object_ids.push audience.activity_object
            end
          end
        end
      end

      unless is_public
        activities.each do |activity|
          # The actor of the activity is always part of the audience.
          @object_ids.push activity.activitable_actor
        end
      end

      # Remove any duplicates from the list. It can happen when, for example, someone
      # post a message to itself.
      @object_ids.uniq!

      respond_to do |format|
        format.html { render layout: false if request.xhr? }
      end

    end

    def destroy
      @activity = Activity.find(params[:id])
      @activity_guid = @activity.guid
      @activity.destroy
      respond_to do |format|
        format.js
      end
    end

  end
end
