require 'panamax_template_validator/version'
require 'panamax_template_validator/repo'
require 'panamax_template_validator/template_file'
require 'panamax_template_validator/template'
require 'panamax_template_validator/image'
require 'refinements/string_colorization'

using StringColorization

module PanamaxTemplateValidator
  def self.validate(file)
    template_file = TemplateFile.new(file)
    template_file.validate

    if template_file.errors.empty?
      puts 'VALID!'.green
      exit 0
    else
      exit 1
    end
  end

  def self.validate_file_list(files)
    errors = []

    files.each do |file|
      template_file = TemplateFile.new(file)
      template_file.validate
      errors += template_file.errors
    end

    if errors.empty?
      puts 'THESE FILES ARE ALL VALID!'.green
      exit 0
    else
      exit 1
    end
  end

  def self.validate_repo
    Repo.new.validate
  end
end
