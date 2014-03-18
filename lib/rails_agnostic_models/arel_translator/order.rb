module RailsAgnosticModels
  module ArelTranslator
    class Order
      attr_accessor :order

      def initialize(order)
        @order = order
      end

      def translate!
        "order(\"#{self.order}\")"
      end
    end
  end
end