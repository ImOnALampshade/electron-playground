JSXDom = require '../jsx-dom'

class VersionNumberView extends JSXDom.View
  constructor: (app) ->
    super(app)

  render: ->
    elem = 
      <div class='version-container'>
        <h1>Hello world!</h1>
        <p>
          We are using {process.versions.node}, 
          {' '}Chromium {process.versions.chrome},
          {' '}and Electron {process.versions.electron}
        </p>
      </div>

    return elem

class ExampleApp extends JSXDom.App
  constructor: (opts) ->
    super()

    @addView
      view: new VersionNumberView

app = new ExampleApp
app.show(document.body)
