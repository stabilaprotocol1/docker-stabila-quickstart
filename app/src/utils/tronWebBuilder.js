const StabilaWeb = require('stabilaweb')
const network = require('../config').network

let instance

module.exports = function () {
  if (!instance) {
    instance = new StabilaWeb(network)
  }
  return instance
}