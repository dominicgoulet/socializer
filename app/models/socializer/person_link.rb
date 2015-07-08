#
# Namespace for the Socializer engine
#
module Socializer
  #
  # Person Link model
  #
  # URLs that are interesting to the {Socializer::Person person}
  #
  class PersonLink < ActiveRecord::Base
    attr_accessible :label, :url

    # Relationships
    belongs_to :person

    # Validations
    validates :label, presence: true
    validates :person, presence: true
    validates :url, presence: true
  end
end
