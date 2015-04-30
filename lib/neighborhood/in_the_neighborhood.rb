require 'geocoder'

class << ActiveRecord::Base

  def in_the_neighborhood(options = {})
    geocoded_by :address, :latitude  => :lat, :longitude => :lng

    after_validation :geocode_if_address

    define_method "address" do
      [street_address, suite_apt, city, state, zip, country].compact.join(', ')
    end

    define_method "geocode_if_address" do
      if address.present?
        geo = Geocoder.search(address)
        if geo.size > 0
          geo = geo.first.data
          # set basic geo
          attrs = {
            :lat => geo['geometry']['location']['lat'],
            :lng => geo['geometry']['location']['lng'],
            :full_address => geo['formatted_address'],
          }
          # set country if necessary
          unless options[:autoset_country] == false
            country = geo['address_components']
              .select { |a| a['types'].include?('country') }.first['long_name']
            attrs[:country] = country if country.present?
          end
          # save attributes
          update_columns(attrs)
        end
      end
    end
  end

end
