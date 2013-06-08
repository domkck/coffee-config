configurator
============

Simple configuration module for node.js

Usage with config.json in project root directory:
``` coffeescript
config = require 'configurator'
config.async __dirname, ->
  port = config.get 'port'
  address = config.production.address
```
