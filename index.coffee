fs = require 'fs'

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

  # Tells configurator which environment to default to
  defaultsTo: (env) ->
    @defaultEnv = env

  # Gets a value for the current env
  get: (item) ->
    @env()[item]

  # Gets the current env
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