module RailsAgnosticModels
  include RailsVersionHelpers
  module ActiveRecordExtensions
    module ClassMethods
      
      def version_agnostic_scope(*args)
        if rails_2?
          named_scope(*args)
        else
          scope(*args)
        end
      end

      def version_agnostic_inheritance_column(column_name)
        if rails_2?
          set_inheritance_column column_name
        else
          self.inheritance_column = column_name
        end
      end
    end

    def self.included(klass)
      klass.extend(ClassMethods)
    end
  end
  ActiveRecord::Base.send(:include, ActiveRecordExtensions)
end