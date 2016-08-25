# frozen_string_literal: true
#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Membership model
  #
  # A {Socializer::Membership} is a link between a {Socializer::Group} and a
  # {Socializer::Person}
  #
  class Membership < ApplicationRecord
    attr_accessible :group_id, :active, :activity_member

    # Relationships
    belongs_to :group, inverse_of: :memberships
    belongs_to :activity_member, class_name: "ActivityObject",
                                 foreign_key: "member_id",
                                 inverse_of: :memberships

    has_one :member, through: :activity_member,
                     source: :activitable,
                     source_type: "Socializer::Person"

    # Validations

    # Named Scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }

    # Class Methods

    # Find memberships where the member_id is equal to the given member_id
    #
    # @param member_id: [Fixnum]
    #
    # @return [ActiveRecord::Relation]
    def self.with_member_id(member_id:)
      where(member_id: member_id)
    end

    # Instance Methods

    def confirm
      update(active: true)
    end
  end
end
