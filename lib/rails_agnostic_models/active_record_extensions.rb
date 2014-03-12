module RailsAgnosticModels
  module ActiveRecordExtensions
    module ClassMethods
      require 'ostruct'

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

      # safely refer to constants that may not be defined. Useful in a gem that might get included in places that might not define EVERY active record model, such as
      # a satelite administration application. Note that you will still need to handle nil cases
      #
      # safe_constant(:Object) # => Object
      # safe_constant(:ClassThatDoesNotExist) # => nil
      # safe_constant("Object") # => Object
      # safe_constant("MyModule::MyClass") # => MyModule::MyClass
      def safe_constant(constant)
        case constant
        when Symbol then
          return top_level_constant_lookup constant
        when String then
          drill_down_constant_lookup(constant)
        else
          return nil
        end
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

      def version_agnostic_default_scope(options = {})
        if rails_2?
          default_scope options
        else
          self.instance_eval "default_scope #{options_to_arel(options)}"
        end
      end

      private 

      def drill_down_constant_lookup(constant)
        constant_tokens = constant.split("::")
        first_token = constant_tokens.first
        return_constant = top_level_constant_lookup first_token
        # go ahead and cut bait if the top level constant isn't there
        return nil unless return_constant
        constant_tokens.drop(1).each do | token |
          if return_constant.constants.include?(token.to_sym)
            return_constant = return_constant.const_get(token)
          else
            return nil
          end
        end
        return return_constant
      end

      def top_level_constant_lookup(constant)
        Object.const_get(constant) if Object.const_defined? constant
      end

      def options_to_arel(options)
        first_key = options.keys.first
        option = OpenStruct.new
        option.key = first_key
        option.value = options[first_key]
        code = "#{translate_arel(option)}"
        options.keys.drop(1).each do |opt|
          option.key = opt
          option.value = options[opt]
          code += ".#{translate_arel(option)}"
        end
        code
      end

      def translate_arel(option)
        case option.key
        when :order then "order('#{option.value}')"
        when :conditions then "where(#{translate_where(option.value)})"
        else ""
        end
      end

      def translate_where(conditions)
        case conditions
        when Hash then return hash_without_braches(conditions)
        when String then return "\"#{conditions}\""
        when Array then return array_without_brackets(conditions)
        end
      end

      def hash_without_braches(hash)
        return hash.keys.inject([]) do |a, key|
          a << "#{key}: #{hash[key]}"
        end.join(', ')
      end

      def array_without_brackets(array)
        return array.inject([]) do |a, value|
          a << array_value(value)
        end.join(", ")
      end

      def array_value(value)
        case value
        when String then return "\"#{value}\""
        else return value
        end
      end
    end
    def self.included(klass)
      klass.extend(ClassMethods)
    end
  end
  ActiveRecord::Base.send(:include, ActiveRecordExtensions)
end
