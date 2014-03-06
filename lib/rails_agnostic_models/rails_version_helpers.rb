module RailsAgnosticModels
  module RailsVersionHelpers
    module ClassMethods
      def rails_2?
        (defined? Rails) && (Rails::VERSION::MAJOR == 2)
      end

      def rails_3?
        (defined? Rails) && (Rails::VERSION::MAJOR == 3)
      end

      def rails_4?
        (defined? Rails) && (Rails::VERSION::MAJOR == 4)
      end

      # Takes a block that will only be executed in a Rails 2 Project
      def rails_2(&block)
        return nil unless rails_2?
        yield
      end

      def rails_3(&block)
        return nil unless rails_3?
        yield
      end

      def rails_4(&block)
        return nil unless rails_4?
        yield
      end
    end
    sdef self.included(klass)
      klass.extend(ClassMethods)
    end
  end
end