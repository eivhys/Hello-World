# frozen_string_literal: true

module Assessments
  module Runners
    module Ruby
      module OverrideDisallowedCalls
        OVERRIDE_DISALLOWED_CALLS = <<-STRING.freeze
  def keep_singleton_methods(klass, singleton_methods)
    klass = Object.const_get(klass)
    singleton_methods = singleton_methods.map(&:to_sym)
    undef_methods = (klass.singleton_methods - singleton_methods)
    undef_methods.each do |method|
      klass.singleton_class.send(:undef_method, method)
    end
  end

  def keep_methods(klass, methods)
    klass = Object.const_get(klass)
    methods = methods.map(&:to_sym)
    undef_methods = (klass.methods(false) - methods)
    undef_methods.each do |method|
      klass.send(:undef_method, method)
    end
  end

  def clean_constants
    (Object.constants - #{Assessments::Runners::Ruby::AllowedConstants::ALLOWED_CONSTANTS}).each do |const|
      Object.send(:remove_const, const) if defined?(const)
    end
  end

  keep_singleton_methods(:Kernel, #{Assessments::Runners::Ruby::AllowedMethods::KERNEL_S_METHODS})
  keep_singleton_methods(:Symbol, #{Assessments::Runners::Ruby::AllowedMethods::SYMBOL_S_METHODS})
  keep_singleton_methods(:String, #{Assessments::Runners::Ruby::AllowedMethods::STRING_S_METHODS})
  keep_singleton_methods(:IO, #{Assessments::Runners::Ruby::AllowedMethods::IO_S_METHODS})
  keep_methods(:Kernel, #{Assessments::Runners::Ruby::AllowedMethods::KERNEL_METHODS})
  keep_methods(:NilClass, #{Assessments::Runners::Ruby::AllowedMethods::NILCLASS_METHODS})
  keep_methods(:TrueClass, #{Assessments::Runners::Ruby::AllowedMethods::TRUECLASS_METHODS})
  keep_methods(:FalseClass, #{Assessments::Runners::Ruby::AllowedMethods::FALSECLASS_METHODS})
  keep_methods(:Enumerable, #{Assessments::Runners::Ruby::AllowedMethods::ENUMERABLE_METHODS})
  keep_methods(:String, #{Assessments::Runners::Ruby::AllowedMethods::STRING_METHODS})

  Kernel.class_eval do
  def `(*args)
    raise NoMethodError, "` is unavailable"
  end
  def system(*args)
    raise NoMethodError, "system is unavailable"
  end
  end

  clean_constants
        STRING
      end
    end
  end
end
