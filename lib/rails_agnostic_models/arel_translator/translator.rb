module RailsAgnosticModels
  module ArelTranslator
    class Translator
      require 'ostruct'

      attr_accessor :search_hash, :arel_string

      def initialize(search_hash)
        @search_hash = search_hash
        @arel_string = ""
      end

      def translate!
        options_to_arel(search_hash)
        arel_string
      end

      private

      def options_to_arel(options)
        first_key = options.keys.first
        option = hash_to_ostruct(first_key, options[first_key])
        self.arel_string << "#{translate_arel(option)}"
        options.keys.drop(1).each do |opt|
          option = hash_to_ostruct(opt, options[opt])
          self.arel_string << ".#{translate_arel(option)}"
        end
        self.arel_string
      end

      def hash_to_ostruct(key, value)
        option = OpenStruct.new
        option.key = key
        option.value = value
        option
      end

      def translate_arel(option)
        case option.key
        when :order then Order.new(option.value)
        when :conditions then Where.new(option.value)
        else ""
        end.translate!
      end
    end
  end
end 