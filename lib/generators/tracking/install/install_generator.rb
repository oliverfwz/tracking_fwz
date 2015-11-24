require 'rails/generators/migration'
require 'bundler'

module Tracking
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "migration/create_trackings.rb", "db/migrate/create_trackings.rb"
      end

      def copy_initializer_file
        copy_file "views/_tracking.html.slim", "app/views/trackings/_tracking.html.slim"
        copy_file "controllers/concerns/tracking_concern.rb", "app/controllers/concerns/tracking_concern.rb"
        copy_file "config/initializers/tracking_fwz.rb", "config/initializers/tracking_fwz.rb"
        copy_file "models/tracking.rb", "app/models/tracking.rb"
      end
    end
  end
end