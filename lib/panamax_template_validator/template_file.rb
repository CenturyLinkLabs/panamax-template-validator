require 'yaml'
require 'refinements/string_colorization'

using StringColorization

module PanamaxTemplateValidator
  class TemplateFile

    attr_reader :errors

    def initialize(file)
      @file = file
      @errors = []
    end

    def validate
      if template = load_template(@file)
        template_validator = Template.new(template)
        template_validator.validate
        errors = template_validator.errors
        if errors.empty?
          puts "#{@file} is valid".green
        else
          puts "#{@file} has the following errors:".red
          puts errors.map { |x| x.red }
          @errors += errors
        end
      else
        no_exist = "#{@file} does not exist"
        puts no_exist
        @errors << no_exist
      end
    end

    private

    def load_template(path)
      YAML.load_file(path)
    rescue Errno::ENOENT
      false
    end
  end
end
