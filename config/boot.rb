require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

ENV['S3_KEY_ID'] = '0D6804VEVGREWB054VG2'
ENV['S3_SECRET_KEY'] = 'ZR5Mzuo5Ye/K2d99EQzmgBMAhXzWrq5Qe0YFOhxC'
ENV['S3_BUCKET'] = 'droptab-production'

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
