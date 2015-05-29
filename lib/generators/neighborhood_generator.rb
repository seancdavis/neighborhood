require 'rake'
require 'rails/generators'

class NeighborhoodGenerator < Rails::Generators::Base
  desc "Add address fields and geocoding to a model"

  source_root File.expand_path('../templates', __FILE__)

  argument :model, :type => :string

  def confirm_model
    @model = model.constantize
  rescue
    puts "Can't find the model: #{model}"
    exit
  end

  def set_references
    @model_pl = @model.to_s.humanize.downcase.pluralize
  end

  def generate_migration
    migration_name = "add_neighborhood_fields_to_#{@model_pl}"
    generate "migration #{migration_name} #{database_fields}"
    insert_into_file(
      Dir.glob("#{Rails.root}/db/migrate/*.rb").last,
      ", :precision => 9, :scale => 6",
      :after => /\:l(at|ng), \:decimal/
    )
  end

  private

    def database_fields
      [
        'street_address',
        'suite_apt',
        'city',
        'state',
        'zip',
        'country',
        'phone',
        'lat:decimal',
        'lng:decimal',
        'full_address:text',
      ].join(' ')
    end

end
