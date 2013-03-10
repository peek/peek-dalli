module Glimpse
  module Views
    class Dalli < View
      def initialize(options = {})
        @duration = 0
        @calls = 0

        setup_subscribers
      end

      def formatted_duration
        "%.2fms" % (@duration * 1000)
      end

      def results
        { :duration => formatted_duration, :calls => @calls }
      end

      private

      def setup_subscribers
        # Reset each counter when a new request starts
        before_request do
          @duration = 0
          @calls = 0
        end

        subscribe(/cache_(.*).active_support/) do |name, start, finish, id, payload|
          @duration += (finish - start)
          @calls += 1
        end
      end
    end
  end
end
