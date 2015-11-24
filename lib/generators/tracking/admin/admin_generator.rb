require 'rails/generators/migration'
require 'bundler'

module Tracking
  module Generators
    class AdminGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def copy_initializer_file
        active = Bundler.load.specs.map { |spec| spec.name }
        if active.include? "activeadmin"
          template "activeadmin/tracking.rb", "app/admin/tracking.rb"
          copy_file "activeadmin/renders/_tracking.html.slim", "app/views/admin/trackings/_tracking.html.slim"
        end
      end
    end
  end
end