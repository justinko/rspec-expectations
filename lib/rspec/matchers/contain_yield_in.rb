module RSpec
  module Matchers
    # :call-seq:
    #   should contain_yield_in(method)
    #   should_not contain_yield_in(method)
    #
    # Passes if method contains yield. You must call this
    # on an object that responds to the method that contains
    # the yield.
    #
    # == Example
    #
    #   class.should contain_yield_in(:method_that_yields)
    def contain_yield_in(method)
      Matcher.new :contain_yield_in, method do |_method_|
        match do |method_caller|
          yielded = []
          method_caller.send(_method_) do
            yielded << true
          end
          yielded.should eql([true])
        end
        
        failure_message_for_should do |method_caller|
          "expected #{method_caller}.#{_method_} to yield"
        end
        
        failure_message_for_should_not do |method_caller|
          "expected #{method_caller}.#{_method_} to not yield"
        end
      end
    end
  end
end