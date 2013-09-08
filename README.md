coffee-config
============

Simple configuration module for node.js

Usage with config.json in project root directory:

`$ npm install coffee-config`
``` coffeescript
config = require 'configurator'
config.async __dirname, ->
  port = config.get 'port'
  address = config.production.address
```
