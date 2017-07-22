# frozen_string_literal: true

#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Notification model
  #
  # The system informing you that something of interest has occurred for you.
  #
  class Notification < ApplicationRecord
    # Relationships
    belongs_to :activity, inverse_of: :notifications
    belongs_to :activity_object, inverse_of: :notifications,
                                 counter_cache: :unread_notifications_count

    # Validations
    validates :activity_id, presence: true
    validates :activity_object_id, presence: true

    # Named Scopes

    # Callbacks

    # Order records by created_at in descending order
    #
    # @return [ActiveRecord::Relation]
    def self.newest_first
      order(created_at: :desc)
    end

    # Class methods - Public

    # Create notifications for the given activity
    #
    # @param activity [Socializer::Activity] the activity to create the
    # notifications for
    #
    # @return [Array] an [Array] of [Socializer::Notification] objects
    def self.create_for_activity(activity)
      # Get all ties related to the audience of the activity
      potential_contact_ids =
        get_potential_contact_ids(activity_id: activity.id)

      potential_contact_ids.each do |contact_id|
        next unless person_in_circle?(parent_contact_id: contact_id,
                                      child_contact_id: activity
                                                          .activitable_actor
                                                          .id)
        # If the contact has the author of the activity in one of his circle.
        create_notification(activity: activity, contact_id: contact_id)
      end
    end

    # Instance methods

    # Marks the notification as read
    #
    # @return [boolean]
    def mark_as_read
      update!(read: true)
    end

    # Is the notification unread?
    #
    # @return [boolean]
    def unread?
      !read
    end

    # Class methods - Private

    # Create a notification for the given activity and contact
    #
    # @param activity [Socializer::Activity]
    # @param contact_id [Socializer::Person]
    #
    # @return [Socializer::Notification]
    def self.create_notification(activity:, contact_id:)
      object = Notification.new do |notification|
        notification.activity = activity
        notification.activity_object = ActivityObject.find_by(id: contact_id)
      end

      object.save!
    end
    private_class_method :create_notification

    # FIXME: Move to Tie or Activity
    def self.get_potential_contact_ids(activity_id:)
      # Activity -> Audience -> ActivityObject -> Circle -> Tie -> contact_id
      Tie.joins(circle: { activity_object: :audiences })
         .merge(Audience.with_activity_id(id: activity_id))
         .distinct
         .pluck(:contact_id)
    end
    private_class_method :get_potential_contact_ids

    # FIXME: Move to ActivityObject or Circle
    def self.person_in_circle?(parent_contact_id:, child_contact_id:)
      # ActivityObject.id = parent_contact_id
      # ActivityObject -> Circle -> Tie -> contact_id = child_contact_id
      ActivityObject.joins(circles: :ties)
                    .with_id(id: parent_contact_id)
                    .merge(Tie.with_contact_id(contact_id: child_contact_id))
                    .pluck(:id)
                    .present?
    end
    private_class_method :person_in_circle?
  end
end
