# acts_as_xapian/lib/acts_as_xapian_i18n.rb:
# Xapian full text search in Ruby on Rails.
#
# Copyright (c) 2008 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/
#
# Documentation
# =============
#
# See ../README.txt for documentation. Please update that file if you edit
# code.

module ActsAsXapianI18n

  @@config = YAML.load_file( File.join(File.dirname(__FILE__), "languages.yml") )

  def ActsAsXapianI18n.stem_language
    @@config[ActsAsXapianI18n.language]['stem']
  end

  def ActsAsXapianI18n.transate_query( query_string )
    ActsAsXapianI18n.transate_date( query_string )
    ActsAsXapianI18n.transate_operators( query_string )

    query_string
  end

  private
  def ActsAsXapianI18n.transate_date( query_string )
    if I18n.locale != 'en'

      # guarantee the backend initialization
      I18n.t "_force_initialization_" unless I18n.backend.initialized?

      loaded_translations = I18n.backend.instance_variable_get '@translations'

      format =
        [I18n.locale, :date, :formats, :default].inject(loaded_translations) do |result, k|
          (x = result[k.to_sym]).nil? ? {} : x
        end

      format_regex = Regexp.new( format.gsub("%d", "[0-9]{1,2}").gsub("%m", "[0-9]{1,2}").gsub("%Y", "[0-9]{4}") )

      query_string.replace(
        query_string.split.inject([]) do |query, word|
          word, term = word.split(':').reverse
          word = Date.strptime( word, format ).strftime( '%Y-%m-%d' ) if format_regex =~ word

          query << [term, word].compact.join(':')
        end.join(' ')
      )
    end
  end

  def ActsAsXapianI18n.transate_operators( query_string )
    if I18n.locale != 'en' && operators = @@config[ActsAsXapianI18n.language]['op']
      operators.each do |op, values|
        values.each do |value|
          query_string.gsub!(" #{value} ", " #{op} ")
        end
      end
    end
  end

  def ActsAsXapianI18n.language
    @@config.keys.include?( I18n.locale ) ? I18n.locale : 'en'
  end
end