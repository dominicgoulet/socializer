#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Verb model
  #
  # Identifies the action that the activity describes.
  #
  class Verb < ActiveRecord::Base
    attr_accessible :display_name

    # Relationships
    has_many :activities, inverse_of: :verb

    # Validations
    validates :display_name, presence: true, uniqueness: true

    # Named Scopes

    # Class Methods

    # Find verbs where the display_name is equal to the given name
    #
    # @param name: [Fixnum]
    #
    # @return [ActiveRecord::Relation]
    def self.with_display_name(name:)
      where(display_name: name)
    end
  end
end
