## GWY/CI by @earcamone
  
 - `   DATE`: 2025-04-14 23:07:25
 - `    RUN`: MANUAL
 - ` BRANCH`: feature/no-ref/final-modular-ci-dependencies-fix
 - `VERSION`: 1.23.4
 - `TIMEOUT`: 300
  
## Secrets Scan


  - [aws-access-token in main.go:28](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L28)
  - [slack-bot-token in main.go:24](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L24)
  - [slack-webhook-url in main.go:25](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L25)


## Secrets Scan Output

```
RuleID:      aws-access-token
Entropy:     3.684184
File:        main.go
Line:        28
Fingerprint: main.go:aws-access-token:28

RuleID:      slack-bot-token
Entropy:     4.132113
File:        main.go
Line:        24
Fingerprint: main.go:slack-bot-token:24

RuleID:      slack-webhook-url
Entropy:     2.500000
File:        main.go
Line:        25
Fingerprint: main.go:slack-webhook-url:25

```

