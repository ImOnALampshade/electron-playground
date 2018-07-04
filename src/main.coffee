electron = require 'electron'
path = require 'path'
url = require 'url'

{ app, BrowserWindow } = electron

mainWindow = null

createWindow =  ->
  mainWindow = new BrowserWindow
    width: 800
    height: 600

  mainUrl = url.format
    pathname: path.join(__dirname, 'main-window', 'index.html')
    protocol: 'file:'
    slashes: true

  mainWindow.loadURL(mainUrl)

  mainWindow.on 'closed', ->
    mainWindow = null

app.on 'ready', createWindow

app.on 'window-all-closed', ->
  if process.platform isnt 'darwin'
    app.quit()

app.on 'activate', ->
  if mainWindow is null
    createWindow()
