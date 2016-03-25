This package sends all console output to a remote syslog server of your choice.

### Settings File

```
{
...
  "hexsprite:syslog-console": {
    "host": "logsetc.papertrailapp.com",
    "port": 1235
    "logToConsole": 1
  },
}
```

### Environment variable

Use `LOG_SYSLOG=1` to enable
