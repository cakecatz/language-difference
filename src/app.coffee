window.hljs = require 'highlight.js'
#hljs.initHighlightingOnLoad()

window.langDiff = {
  translate: (pos, lang, codeLines)->
    elementId = 'code-panel-' + pos
    body = '<pre><code class="' + lang + '" id="' + elementId + '">'
    numberBody = '<pre><code class="' + lang + '" id="' +
      elementId + '-number' + '">'

    for line, i in codeLines
      numberBody += langDiff.lineNumber(i + 1)
      console.log numberBody
      body += '<div class="code-line">' + line + '</div><br/>'

    return {
      id: elementId
      body: body + '</code></pre>'
      numberBody: numberBody + '</code></pre>'
    }

  lineNumber: (number)->
    body = '<div class="line-number">'
    for i in [0...(5 - number.toString().length)]
      body += ' '
    return body + number + ' </div>'
}