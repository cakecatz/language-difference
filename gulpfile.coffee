gulp = require 'gulp'
foreach = require 'gulp-foreach'
rename = require 'gulp-ext-replace'
tap = require 'gulp-tap'
tojson = require './src/code2json'

gulp.task 'convert', ->
  path = 'code/*'
  gulp.src path
    .pipe tap (file, t)->
      file.contents = new Buffer( tojson.convert( file.path ) )
      return t
    .pipe rename '.json'
    .pipe gulp.dest './public/code/'

gulp.task 'default', ['convert']
