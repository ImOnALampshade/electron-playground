class View
  constructor: (app) ->
    @app = app
    @prerendered = null

  render: ->
    elem = 
      <span class='not-implemented'>
        Unimplemented <code>View.render()</code>
      </span>
    return elem

  prerender: ->
    unless @prerendered isnt null
      @prerendered = @render()

  appendToElement: (root) ->
    @prerender()
    @element = @prerendered
    @element.view = this
    root.appendChild(@element)

class App
  constructor: ->
    @views = {}
    @viewList = []

  addView: (opts) ->
    view = opts.view
    @viewList.push(view)

    if opts.name
      @views[opts.name] = view

  render: ->
    elem = <div class='app-container'></div>

    for view in @viewList
      view.appendToElement(elem)

    return elem

  show: (root) ->
    @element = @render()
    root.appendChild(@element)

module.exports =
  createElement: (tag, attributes, elements...) ->
    el = document.createElement(tag)
    for name, value of attributes
      # If it's a callback, then we don't want to use setAttribute
      if value instanceof Function

        # Better to use event listeners than "on*" events, so switch it to that
        if name.startsWith('on')
          el.addEventListener name.slice(2), value
        else
          el[name] = value
      else
        # Set attribute
        el.setAttribute(name, value)

    addAll = (elements) ->
      for element in elements
        if element instanceof HTMLElement
          el.appendChild(element)
        else if element instanceof Array
          addAll(element)
        else if element instanceof View
          element.appendToElement(el)
        else if element is null
          # Ignore null elements
        else
          text = element.toString()
          el.appendChild(document.createTextNode(text))

    addAll(elements)


    return el


  View: View
  App: App

