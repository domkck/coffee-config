fs = require 'fs'


###
What this must do:
  - load configs from config.json in project root depending on NODE_ENV
  - throw an error if no env is specified
  - expose sync and async api (server startup & everywhere else)

What this should do:
  - support .coffee, .yaml & other formats
  - have an option to default to env if none is specified
###

class Configurator

  constructor: ->
    @defaultEnv = 'development'

  # Loads configuration synchronously
  sync: (dir) ->
    @_loadConfigFileSync dir

  # Loads configuration asynchronously
  async: (dir, callback) ->
    @_loadConfigFileAsync dir, =>
      callback() if callback?

  # Tells configurator which configuration to default to
  defaultsTo: (env) ->
    @defaultEnv = env

  # Gets a value
  get: (item) ->
    @env()[item]

  env: ->
    env = process.env.NODE_ENV
    env ?= @defaultEnv
    @[env]

  _loadConfigFileSync: (dir) ->
    data = fs.readFileSync dir+'/config.json'
    json = JSON.parse data
    for key, value of json
        @[key] = value
    this

  _loadConfigFileAsync: (dir, callback) ->
    data = fs.readFile dir+'/config.json', (err, data) =>
      if err then throw err
      json = JSON.parse data
      for key, value of json
        @[key] = value
      callback()

configurator = null

module.exports = ( ->
  configurator = new Configurator() unless configurator?
  return configurator
  ).call()