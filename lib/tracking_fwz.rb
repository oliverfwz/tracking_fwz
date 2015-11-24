require "tracking_fwz/version"

module TrackingFwz
  class Engine < ::Rails::Engine
  end

  mattr_accessor :model_devise
  @@model_devise = nil

  def self.setup
    yield self
  end
end
