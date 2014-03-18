module RailsAgnosticModels
  module ArelTranslator
    module CollectionConverters
      private
      
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
  end
end