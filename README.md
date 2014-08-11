# Panamax Template Validator

Validator for panamax templates. Runs a quick sanity check against .pmx files.

## Installation

Add this line to your application's Gemfile:

    gem 'panamax_template_validator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install panamax_template_validator

## Usage

##### validate a single file:
```
PanamaxTemplateValidator.validate('/path/to/your_template.pmx')
```

##### validate a collection of files:
```
PanamaxTemplateValidator.validate_file_list(['/path/to/your_template.pmx', '/path/to/another_template.pmx'])
```

##### validate all *.pmx files in the current working directory:

```
PanamaxTemplateValidator.validate_repo
```

##### we generally create a default rake task in our template repos that our CI solution will execute, for example:

``` 
# Rakefile
require 'rake'
require 'panamax_template_validator'

task :default do
  PanamaxTemplateValidator.validate_repo
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/panamax_template_validator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
