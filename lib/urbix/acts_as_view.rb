# urbix/lib/urbix/acts_as_view.rb
module Urbix
  module ActsAsView
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def acts_as_view(options = {})
        # your code will go here
      end
    end
  end
end
 
ActiveRecord::Base.send :include, Urbix::ActsAsView

