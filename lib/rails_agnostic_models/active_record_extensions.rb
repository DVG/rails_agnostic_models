module RailsAgnosticModels
  module ActiveRecordExtensions
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