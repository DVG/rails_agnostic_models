module RailsAgnosticModels
  module ActiveRecordExtensions
    module ClassMethods

      # Checks if the host app is a Rails 2 app
      def rails_2?
        rails_loaded && (Rails::VERSION::MAJOR == 2)
      end

      # Checks if the host app is a Rails 3 app
      def rails_3?
        rails_loaded && (Rails::VERSION::MAJOR == 3)
      end

      # Checks if the host app is a Rails 4 app
      def rails_4?
        rails_loaded && (Rails::VERSION::MAJOR == 4)
      end

      # Checks if Rails is loaded
      def rails_loaded
        defined? Rails
      end

      # Takes a block that will only be executed in a Rails 2 Project
      def rails_2(&block)
        return nil unless rails_2?
        yield
      end

      # Code to be executed insode of a Rails 3 app
      def rails_3(&block)
        return nil unless rails_3?
        yield
      end

      # Code to be executed inside of a Rails 4 app
      def rails_4(&block)
        return nil unless rails_4?
        yield
      end

      # Code to be executed only inside of a rails app 
      def rails(&block)
        return nil unless rails_loaded
        yield
      end

      # Defines the appropraite scope based on the version of Rails
      def version_agnostic_scope(*args)
        if rails_2?
          named_scope(*args)
        else
          scope(*args)
        end
      end

      # Sets the inheritance column based on the version of Rails
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
