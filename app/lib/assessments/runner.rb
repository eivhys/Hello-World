# frozen_string_literal: true

module Assessments
  class Runner
    Outcome = Struct.new(:result, :time_spent) do
      def completed?
        error_message.nil?
      end
    end

    class << self
      def call(implementation, input, timeout, evaluator_class)
        new(implementation, input, timeout, evaluator_class).call
      end
    end

    def call
      @evaluator_class.call(@implementation, @input, @timeout)
    end

    def initialize(implementation, input, timeout = 10, evaluator_class)
      @implementation = implementation
      @input = input
      @timeout = timeout
      @evaluator_class = evaluator_class
    end
  end
end
