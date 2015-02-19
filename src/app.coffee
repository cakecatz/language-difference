hljs = require 'highlight.js'
langDiff = require './langDiff.coffee'

window.app = {
  reqListener: (lang, pos)->
    return ->
      codeColumn = document.querySelector '.' + pos + '-code .code-column'
      numberColumn = document.querySelector '.' + pos + '-code .number-column'

      while codeColumn.firstChild
        codeColumn.removeChild codeColumn.firstChild

      while numberColumn.firstChild
        numberColumn.removeChild numberColumn.firstChild

      o = langDiff.translate pos, lang, JSON.parse(@responseText)
      codeColumn.insertAdjacentHTML 'beforeend', o.body

      document.querySelector '.' + pos + '-code .number-column'
        .insertAdjacentHTML 'beforeend', o.numberBody

      hljs.highlightBlock document.querySelector('#' + o.id)
      hljs.highlightBlock document.querySelector('#' + o.id + '-number')

      document.querySelector('.' + pos + '-code .language-name').textContent = lang
      langSiteElem = document.querySelector('.' + pos + '-code .language-site')
      langSiteElem.removeChild langSiteElem.firstChild if langSiteElem.firstChild

      langSiteElem.insertAdjacentHTML 'beforeend', langDiff.tag 'a', 'OFFICIAL SITE', {
          href: app.langInfo[lang.toLowerCase()].url
          target: "languageSite"
        }

      app.languSelectorEvent()

  changeLang: (lang, pos)->
    req = new XMLHttpRequest()
    req.onload = @reqListener lang, pos
    req.open "get", "./code/" + lang.toLowerCase() + ".json", true
    req.setRequestHeader 'Cache-Control', 'no-cache'
    req.send()

  languSelectorEvent: ->
    langNames = document.querySelectorAll 'span.language-name'
    langSelector = document.getElementById 'language-selector'
    langSelectorLabel = document.querySelectorAll '#language-selector span'

    for i in [0...langNames.length]
      langNames[i].onclick = ->
        langSelector.style.display = 'initial'
        langSelector.style.left = @getBoundingClientRect().left + 'px'
        langSelector.style.top = @getBoundingClientRect().bottom + 'px'
        if window.innerWidth / 2 > @getBoundingClientRect().left
          langSelector.pos = 'left'
        else
          langSelector.pos = 'right'

    for i in [0...langSelectorLabel.length]
      langSelectorLabel[i].onclick = ->
        app.changeLang @textContent, @parentNode.pos

    langSelector.onclick = ->
      this.style.display = 'none'

  loadLanguageInfo: ->
    req = new XMLHttpRequest()
    req.onload = ->
      app.langInfo = JSON.parse @response
    req.open 'get', "./langinfo.json", true
    req.setRequestHeader 'Cache-Control', 'no-cache'
    req.send()

  langInfo: {}

  init: ->
    @loadLanguageInfo()
    @changeLang 'Rust', 'left'
    @changeLang 'C', 'right'

}

app.init()

