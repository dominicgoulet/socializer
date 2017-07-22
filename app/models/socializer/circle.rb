# frozen_string_literal: true

#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Circle model
  #
  # Circles make it easy to share the right things with the right people.
  # You can organize the people you follow and the people who follow you,
  # by grouping them into Circles.
  #
  # The association between a {Socializer::Person person} and a
  # {Socializer::Circle circle} is called a {Socializer::Tie tie}.
  #
  class Circle < ApplicationRecord
    include ObjectTypeBase

    # Relationships
    belongs_to :activity_author, class_name: "ActivityObject",
                                 foreign_key: "author_id",
                                 inverse_of: :circles

    has_one :author, through: :activity_author,
                     source: :activitable,
                     source_type: "Socializer::Person"

    has_many :ties, inverse_of: :circle
    has_many :activity_contacts, through: :ties
    has_many :contacts, through: :activity_contacts,
                        source: :activitable,
                        source_type: "Socializer::Person"

    # Validations
    validates :activity_author, presence: true
    validates :display_name, presence: true,
                             uniqueness: { scope: :author_id,
                                           case_sensitive: false }

    delegate :count, to: :ties, prefix: true

    # Named Scopes

    # Class Methods

    # Find circles where the id is equal to the given id
    #
    # @param id: [Integer]
    #
    # @return [ActiveRecord::Relation]
    def self.with_id(id:)
      where(id: id)
    end

    # Find circles where the author_id is equal to the given id
    #
    # @param id: [Integer]
    #
    # @return [ActiveRecord::Relation]
    def self.with_author_id(id:)
      where(author_id: id)
    end

    # Find circles where the display_name is equal to the given name
    #
    # @param name: [String]
    #
    # @return [ActiveRecord::Relation]
    def self.with_display_name(name:)
      where(display_name: name)
    end

    # Find all records where display_name is like "query"
    #
    # @param query: [String]
    #
    # @return [ActiveRecord::Relation]
    def self.display_name_like(query:)
      where(arel_table[:display_name].matches(query))
    end

    # Instance Methods

    # Add a contact to the circle
    #
    # @param contact_id [Integer] The guid of the person to add to the circle
    #
    # @return [Socializer:Circle/ActiveRecord::RecordInvalid] The resulting
    # object is returned if validations passes.
    # Raises ActiveRecord::RecordInvalid when the record is invalid.
    def add_contact(contact_id)
      ties.create!(contact_id: contact_id)
    end

    # Remove a contact from the circle
    #
    # @param contact_id [Integer] The guid of the person to add to the circle
    #
    # @return [Socializer:Circle/FalseClass] Deletes the record in the database
    # and freezes this instance to reflect that no changes should be made
    # (since they can"t be persisted). If the before_destroy callback returns
    # false the action is cancelled and remove_contact returns false.
    def remove_contact(contact_id)
      tie = ties.find_by(contact_id: contact_id)
      tie.destroy
    end
  end
end
