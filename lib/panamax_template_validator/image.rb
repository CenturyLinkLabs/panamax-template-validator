require 'net/http'

module PanamaxTemplateValidator
  class Image
    attr_reader :errors

    def initialize(image_attrs, image_names)
      @image_attrs = image_attrs
      @image_names = image_names
      @errors = []
    end

    def validate
      validate_presence_of('name')
      validate_presence_of('source')
      validate_source_exists_publicly
      validate_presence_of_container_ports
      validate_uniqueness_of_host_ports
      validate_volumes_have_container_path
      validate_presence_of_env_var
      validate_presence_of_link_alias
      validate_linked_service_exists
    end

    private

    def validate_linked_service_exists
      Array(@image_attrs['links']).each_with_index do |link, i|
        unless @image_names.include? link['service']
          @errors << "#{@image_attrs['name']}'s link ##{i + 1} is linked to a service (#{link['service']}) that does not exist in this template"
        end
      end
    end

    def validate_presence_of_link_alias
      Array(@image_attrs['links']).each_with_index do |link, i|
        if link['alias'].to_s == ''
          @errors << "#{@image_attrs['name']}'s link ##{i + 1} does not have an alias"
        end
      end
    end

    def validate_source_exists_publicly
      source = @image_attrs['source'].split(':')[0]
      res1 = Net::HTTP.get_response(URI("https://registry.hub.docker.com/u/#{source}/")).code
      res2 = Net::HTTP.get_response(URI("https://registry.hub.docker.com/_/#{source}/")).code

      unless [res1, res2].include?('200')
        @errors << "#{@image_attrs['name']}'s source does not exist publicly in the docker index"
      end
    end

    def validate_presence_of_env_var
      Array(@image_attrs['environment']).each do |env|
        if env['variable'].to_s == ''
          @errors << 'each environment entry should have a variable (name)'
        end
      end
    end

    def validate_volumes_have_container_path
      Array(@image_attrs['volumes']).each do |vol|
        if vol['container_path'].to_s == ''
          @errors << 'each volume must have a container path'
        end
      end
    end

    def validate_presence_of_container_ports
      Array(@image_attrs['ports']).each do |port|
        if port['container_port'].to_s == ''
          @errors << 'each port must have a container port'
        end
      end
    end

    def validate_uniqueness_of_host_ports
      host_ports = Array(@image_attrs['ports']).map { |p| p['host_port'] }.compact

      if host_ports.length != host_ports.uniq.length
        @errors << 'host ports must be unique'
      end
    end

    def validate_presence_of(key)
      if @image_attrs[key].nil? || @image_attrs[key] == ''
        @errors << "image: #{@image_attrs['name']}'s #{key} is required"
      end
    end

    def validate_length_of(key, inequality, length)
      return unless @image_attrs[key]
      unless @image_attrs[key].length.send(inequality, length)
        @errors << "image: #{@image_attrs['name']}'s #{key} should #{inequality} #{length}"
      end
    end
  end
end
