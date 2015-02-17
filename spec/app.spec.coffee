langDiff = require '../src/langDiff.coffee'

describe "CreateTag", ->
  it "create `tag` tag with one attribute.", ->
    expect langDiff.tag 'tag','',{
        test: 'Hello'
      }
      .toBe '<tag test="Hello"></tag>'
