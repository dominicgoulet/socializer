module Socializer
  class Comment < ActiveRecord::Base
    include Socializer::ObjectTypeBase

    attr_accessible :object_id, :content

    belongs_to :embedded_author,           class_name: 'ActivityObject', foreign_key: 'author_id'
    belongs_to :embedded_commented_object, class_name: 'ActivityObject', foreign_key: 'object_id'

    def author
      @author ||= embedded_author.embeddable
    end

    def commented_object
      @commented_object ||= embedded_commented_object.embeddable
    end

  end
end
