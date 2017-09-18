# frozen_string_literal: true

#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Tie model
  #
  # A {Socializer::Tie} is a link between a {Socializer::Circle} and a
  # {Socializer::Person}
  #
  class Tie < ApplicationRecord
    # Relationships
    belongs_to :circle, inverse_of: :ties
    belongs_to :activity_contact, class_name: "ActivityObject",
                                  foreign_key: "contact_id",
                                  inverse_of: :ties

    has_one :contact, through: :activity_contact,
                      source: :activitable,
                      source_type: "Socializer::Person",
                      dependent: :destroy

    # Validations
    validates :circle, presence: true
    validates :activity_contact, presence: true

    # Named Scopes

    # Class Methods

    # Find ties where the circle_id is equal to the given circle_id
    #
    # @param circle_id: [Integer]
    #
    # @return [ActiveRecord::Relation]
    def self.with_circle_id(circle_id:)
      where(circle_id: circle_id)
    end

    # Find ties where the contact_id is equal to the given contact_id
    #
    # @param contact_id: [Integer]
    #
    # @return [ActiveRecord::Relation]
    def self.with_contact_id(contact_id:)
      where(contact_id: contact_id)
    end
  end
end
