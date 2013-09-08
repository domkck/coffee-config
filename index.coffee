fs = require 'fs'

class Configurator

  constructor: ->
    @defaultEnv = 'development'

  # Loads configuration synchronously
  sync: ->
    @_loadConfigFileSync()

  # Loads configuration asynchronously
  async: (callback) ->
    @_loadConfigFileAsync =>
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

  _loadConfigFileSync: ->
    data = fs.readFileSync process.cwd()+'/config.json'
    json = JSON.parse data
    for key, value of json
        @[key] = value
    this

  _loadConfigFileAsync: (callback) ->
    data = fs.readFile process.cwd()+'/config.json', (err, data) =>
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