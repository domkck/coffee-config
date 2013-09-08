coffee-config
============

Simple configuration module for node.js

Usage with config.json in project root directory:

`$ npm install coffee-config`
``` coffeescript
config = require 'configurator'
config.async ->
  port = config.get 'port'
  address = config.production.address

# or

config.sync()
port = config.get 'port'
address = config.production.address
```
