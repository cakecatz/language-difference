langDiff = {
  translate: (pos, lang, codeLines)->
    elementId = 'code-panel-' + pos

    contentBody = ''
    lineNumbers = ''
    
    for line, i in codeLines
      lineNumbers += langDiff.lineNumber(i + 1)
      contentBody += line + "\n"

    body = @tag 'pre', @tag 'code', contentBody, {
      class: langDiff.resolveName(lang)
      id: elementId
    }

    numBody = @tag 'pre', @tag 'code', lineNumbers, {
      class: langDiff.resolveName(lang)
      id: elementId + '-number'
    }

    return {
      id: elementId
      body: body
      numberBody: numBody
    }

  lineNumber: (number)->
    body = '<div class="line-number">'
    for i in [0...(5 - number.toString().length)]
      body += ' '
    return body + number + ' </div>'

  resolveName: (name)->
    switch name
      when 'C','c'
        return 'cpp'
      when 'JavaScript'
        return 'js'
      else name.toLowerCase()

  tag: (tagName, content, attributes)->
    body = '<' + tagName
    for attr,val of attributes
      body += ' ' + attr + '="' + val + '"'
    return  body + '>' + content + '</' + tagName + '>'
}

module.exports = langDiff