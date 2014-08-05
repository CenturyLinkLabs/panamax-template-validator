module PanamaxTemplateValidator
  class Template
    attr_reader :errors

    def initialize(template_attrs)
      @template_attrs = template_attrs
      @errors = []
    end

    def validate
      validate_presence_of('name')
      validate_presence_of('description')
      validate_presence_of('documentation')
      validate_length_of('documentation', '>', 40)
      image_names = @template_attrs['images'].map { |image| image['name'] }
      @template_attrs['images'].each do |image_attrs|
        image = Image.new(image_attrs, image_names)
        image.validate
        @errors += image.errors
      end
    end

    private

    def validate_presence_of(key)
      if @template_attrs[key].nil? || @template_attrs[key] == ''
        @errors << "template #{key} is required"
      end
    end

    def validate_length_of(key, inequality, length)
      return unless @template_attrs[key]
      unless @template_attrs[key].length.send(inequality, length)
        @errors << "template #{key} should #{inequality} #{length}"
      end
    end
  end
end
