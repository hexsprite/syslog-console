Npm.depends({
  'syslog-tls': '1.0.0'
});

Package.describe({
  name: 'hexsprite:syslog-console',
  version: '0.0.1',
  summary: 'Send all console output to a remote syslog server of your choice',
  git: 'https://github.com/hexsprite/syslog-console',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  api.use('ecmascript');
  api.use('coffeescript');
  api.addFiles('syslog-console.coffee', 'server');
});

Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('coffeescript');
  api.use('tinytest');
  api.use('hexsprite:syslog-console');
  api.addFiles('syslog-console-tests.js');
});
