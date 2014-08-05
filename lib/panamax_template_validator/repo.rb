require 'refinements/string_colorization'

using StringColorization

module PanamaxTemplateValidator
  class Repo

    def initialize
      @errors = []
    end

    def validate
      puts ' --- Validating .pmx files in working directory --- '
      Dir.glob('*.pmx') do |file|
        validate_file(file)
      end

      if @errors.empty?
        puts 'valid!'
        exit 0
      else
        puts @errors
        exit 1
      end
    end

    private

    def validate_file(file)
      if template = load_template(file)
        template_validator = Template.new(template)
        template_validator.validate
        errors = template_validator.errors
        if errors.empty?
          puts "#{file} is valid".green
        else
          puts "#{file} has the following errors:".red
          puts errors.map { |x| x.red }
          @errors += errors
        end
      else
        no_exist = "#{file} does not exist"
        puts no_exist
        @errors << no_exist
      end
    end

    def load_template(path)
      YAML.load_file(path)
    rescue Errno::ENOENT
      false
    end
  end
end
