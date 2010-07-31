require 'spec_helper'

module RSpec
  module Matchers
    describe 'should contain_yield_in(method)' do
      context 'method containing yield' do
        subject do
          Class.new do
            def initialize
              yield
            end
          end
        end
        
        it 'passes' do
          subject.should contain_yield_in(:new)
        end
        
        it 'provides a failure message for should_not' do
          lambda {
            subject.should_not contain_yield_in(:new) 
          }.should fail_with(/expected #<Class.*>.new to not yield/)
        end
      end
      
      context 'method not containing yield' do
        subject do
          Class.new do
            def initialize
            end
          end
        end
        
        it 'fails' do
          subject.should_not contain_yield_in(:new)
        end
        
        it 'provides a failure message for should' do
          lambda {
            subject.should contain_yield_in(:new) 
          }.should fail_with(/expected #<Class.*>.new to yield/)
        end
      end
    end
  end
end