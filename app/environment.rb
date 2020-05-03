require 'bundler'
Bundler.require(:default)
 
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../../', __FILE__)
 
ENV['RACK_ENV'] ||= 'development'
 
require 'grape'
require 'grape-entity'
require 'grape-swagger'
require 'grape-swagger-entity'
require 'grape-swagger-representable'
require 'csv'
require 'models'
require 'entities'
require 'repositories'
require 'api'
