# frozen_string_literal: true

module Assessments
  module Runners
    module Ruby
      class Evaluator
        def self.call(implementation, input, timeout)
          new(implementation, input, timeout).call
        end

        def initialize(implementation, input, timeout)
          @implementation = implementation
          @input = input
          @timeout = timeout
        end

        def call
          evaluate
        end

        private

        def start!
          @start_time = Time.now
        end

        def evaluate
          with_safe_ruby_file do |file|
            start!
            thread = Thread.new do
              %x(ruby #{file.path})
            end

            thread.kill unless thread.join(@timeout)

            outcome = begin
              Marshal.load(thread.value)
            rescue StandardError
              nil
            end
            ::Assessments::Runner::Outcome.new(outcome, Time.now - @start_time)
          end
        end

        def with_safe_ruby_file
          Tempfile.create(["runner", ".rb"]) do |file|
            file.write(Assessments::Runners::Ruby::OverrideDisallowedCalls::OVERRIDE_DISALLOWED_CALLS)
            file.write(<<-STRING
        #{@implementation}
        print Marshal.dump(solution(#{@input}))
            STRING
                      )
            file.rewind
            yield file
          end
        end
      end
    end
  end
end
