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
        file = TemplateFile.new(file)
        file.validate
        @errors += file.errors
      end

      if @errors.empty?
        puts 'THIS REPO IS VALID!'.green
        exit 0
      else
        exit 1
      end
    end
  end
end
