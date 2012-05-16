require "action_dispatch/testing/assertions/routing"

module RSpec::Rails
  module RoutingExampleGroup
    extend ActiveSupport::Concern
    include RSpec::Rails::RailsExampleGroup
    include ActionDispatch::Assertions::RoutingAssertions
    include RSpec::Rails::Matchers::RoutingMatchers
    include RSpec::Rails::Matchers::RoutingMatchers::RouteHelpers

    included do
      metadata[:type] = :routing

      before do
        if Gem::Version.new(Rails.version) >= Gem::Version.new('3.1.0')
          @routes = RSpec.configuration.application.routes
        else
          @routes = ::Rails.application.routes
        end
      end
    end

    attr_reader :routes

    private

    def method_missing(m, *args, &block)
      routes.url_helpers.respond_to?(m) ? routes.url_helpers.send(m, *args) : super
    end
  end
end
