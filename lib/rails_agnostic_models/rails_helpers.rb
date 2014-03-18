module RailsAgnosticModels
  module RailsHelpers
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
    end
    def self.included(klass)
      klass.extend(ClassMethods)
    end
  end
end