# frozen_string_literal: true

require "dry/initializer"

#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Add the default circles for the person
  #
  class AddDefaultCircles
    # Initializer
    #
    extend Dry::Initializer

    # Adds the person keyword argument to the initializer, ensures the type
    # is [Socializer::Person], and creates a private reader
    option :person, type: Types.Strict(Person), reader: :private

    # Class Methods

    # Invoke the AddDefaultCircles. This is the primary public API method.
    # Add the default circles
    #
    # @param person: [Socializer::Person] the person to create the default
    # circles for
    #
    # @return [Socializer::AddDefaultCircles]
    def self.call(person:)
      new(person: person).call
    end

    # Instance Methods

    # Invoke the AddDefaultCircles instance. This is the primary public API
    # method.
    # Add the default circles
    def call
      create_circle(display_name: "Friends",
                    content: friends_content)

      create_circle(display_name: "Family",
                    content: family_content)

      create_circle(display_name: "Acquaintances",
                    content: acquaintances_content)

      create_circle(display_name: "Following",
                    content: following_content)
    end

    private

    def create_circle(display_name:, content: nil)
      params = { display_name: display_name, content: content }
      operation = Circle::Operations::Create.new(actor: person)
      operation.call(params: params)
    end

    def acquaintances_content
      "A good place to stick people you've met but " \
      "aren't particularly close to."
    end

    def family_content
      "Your close and extended family, with as " \
      "many or as few in-laws as you want."
    end

    def following_content
      "People you don't know personally, but whose " \
      "posts you find interesting."
    end

    def friends_content
      "Your real friends, the ones you feel " \
      "comfortable sharing private details with."
    end
  end
end
