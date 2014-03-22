module RailsAgnosticModels
  module ArelTranslator
    class Where
      include CollectionConverters
      attr_accessor :conditions

      def initialize(conditions)
        @conditions = conditions
      end

      def translate!
        case self.conditions
        when Hash then return wrap_where hash_without_braches(self.conditions)
        when String then return wrap_where "\"#{self.conditions}\""
        when Array then return wrap_where array_without_brackets(self.conditions)
        else raise UnkownArgumentException
        end
      end

      private

      def wrap_where(str)
        "where(#{str})"
      end
    end
  end
end
