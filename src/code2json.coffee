fs = require 'fs'

code2json = {
  convert: (fileName)->
    content = fs.readFileSync fileName, {
      encoding: 'utf8'
    }
    lines = content.split("\n")
    return JSON.stringify lines
}

if process.argv[2]
   console.log code2json.convert process.argv[2]

module.exports = code2json