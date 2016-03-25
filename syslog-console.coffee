if not process.env.LOG_SYSLOG or process.env.IS_MIRROR
  return

pkgName = 'hexsprite:syslog-console'
syslog = Npm.require('syslog-tls')
util = Npm.require('util')
os = Npm.require('os')
domain = Npm.require('domain')
settings = Meteor.settings[pkgName]

# setup domain so that uncaught exceptions won't crash Meteor
d = domain.create()
d.on 'error', (err) ->
  process.stdout.write "syslog-console error: #{err.stack}\n"

# setup logger
logger = null
d.run ->
  logger = syslog.createClient settings.port, settings.host, name: os.hostname()

console.log "#{pkgName}: logging to #{settings.host}:#{settings.port}
  as #{os.hostname()}"

# override console functions to log to syslog
formatArgs = (args) ->
  [util.format.apply(util.format, Array.prototype.slice.call(args))]

consoleMapping =
  log: 'info'
  warn: 'warning'
  error: 'error'
  info: 'info'

# @_originalConsole = {}
logToConsole = settings.logToConsole
for funcName, logName of consoleMapping
  originalFunc = console[funcName]
  # @_originalConsole[funcName] = ->
  log = ->
    formatted = formatArgs(arguments)
    logger[logName].apply(logger, [formatted[0]])
  if logToConsole
    _log = log
    log = ->
      _log.call(logger, arguments[0])
      originalFunc.apply console, arguments
  console[funcName] = log
