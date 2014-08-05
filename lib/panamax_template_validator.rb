require 'panamax_template_validator/version'
require 'yaml'
require_relative 'panamax_template_validator/repo'
require_relative 'panamax_template_validator/template'
require_relative 'panamax_template_validator/image'

module PanamaxTemplateValidator
  def self.validate
    Repo.new.validate
  end
end
