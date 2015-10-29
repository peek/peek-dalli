require 'atomic'

module Peek
  module Views
    class Dalli < View
      def initialize(options = {})
        @duration = Atomic.new(0)
        @calls = Atomic.new(0)

        @reads = Atomic.new(0)
        @misses = Atomic.new(0)
        @writes = Atomic.new(0)
        @others = Atomic.new(0)

        setup_subscribers
      end

      def formatted_duration
        ms = @duration.value * 1000
        if ms >= 1000
          "%.2fms" % ms
        else
          "%.0fms" % ms
        end
      end

      def context
        {
          :reads => @reads.value,
          :misses => @misses.value,
          :writes => @writes.value,
          :others => @others.value,
        }
      end

      def results
        {
          :duration => formatted_duration,
          :calls => @calls.value,
        }
      end

      private

      def setup_subscribers
        # Reset each counter when a new request starts
        before_request do
          @duration.value = 0
          @calls.value = 0

          @reads.value = 0
          @misses.value = 0
          @writes.value = 0
          @others.value = 0
        end

        subscribe(/cache_(.*).active_support/) do |name, start, finish, id, payload|
          case name
          when 'cache_read.active_support'
            @reads.update { |value| value + 1 }
          when 'cache_miss.active_support'
            @misses.update { |value| value + 1 }
          when 'cache_write.active_support'
            @writes.update { |value| value + 1 }
          else
            @others.update { |value| value + 1 }
          end

          duration = (finish - start)
          @duration.update { |value| value + duration }
          @calls.update { |value| value + 1 }
        end
      end
    end
  end
end
