## GWY/CI by @earcamone
  
 - `   DATE`: 2025-04-14 23:07:25
 - `    RUN`: MANUAL
 - ` BRANCH`: feature/no-ref/final-modular-ci-dependencies-fix
 - `VERSION`: 1.23.4
 - `TIMEOUT`: 300
  
## Linting Scan
  - [ratelimiter_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/ratelimiter/ratelimiter_test.go#L74): `Error return value of w.Write is not checked`
  - [middleware_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/errorscheme/middleware_test.go#L37): `Error return value of w.Write is not checked`
  - [middleware_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/errorscheme/middleware_test.go#L65): `Error return value of json.Unmarshal is not checked`
  - [middleware_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/errorscheme/middleware_test.go#L89): `Error return value of json.Unmarshal is not checked`
  - [middleware_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/errorscheme/middleware_test.go#L102): `Error return value of w.Write is not checked`
  - [response.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/errorscheme/response.go#L28): `Error return value of (*encoding/json.Encoder).Encode is not checked`
  - [response_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/errorscheme/response_test.go#L22): `Error return value of json.Unmarshal is not checked`
  - [books_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/routes/books/books_test.go#L86): `Error return value of (*encoding/json.Encoder).Encode is not checked`
  - [main_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main_test.go#L39): `Error return value of cmd.Process.Kill is not checked`
  - [ratelimiter.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/ratelimiter/ratelimiter.go#L127): `field allowed is unused`
  - [middleware.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/errorscheme/middleware.go#L107): `S1002: should omit comparison to bool constant, can be simplified to !wrapper.written`
  - [ratelimiter.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/middleware/ratelimiter/ratelimiter.go#L185): `S1024: should use time.Until instead of t.Sub(time.Now())`
  - [main_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main_test.go#L67): `ineffectual assignment to err`
  - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L85): `SA1016: syscall.SIGKILL cannot be trapped (did you mean syscall.SIGTERM?)`


## Linting Scan Output

```
api/middleware/ratelimiter/ratelimiter_test.go:74:11: Error return value of `w.Write` is not checked (errcheck)
			w.Write([]byte("OK"))
			       ^
api/middleware/errorscheme/middleware_test.go:37:11: Error return value of `w.Write` is not checked (errcheck)
			w.Write([]byte("Chillin, bro"))
			       ^
api/middleware/errorscheme/middleware_test.go:65:17: Error return value of `json.Unmarshal` is not checked (errcheck)
		json.Unmarshal(w.Body.Bytes(), &resp)
		              ^
api/middleware/errorscheme/middleware_test.go:89:17: Error return value of `json.Unmarshal` is not checked (errcheck)
		json.Unmarshal(w.Body.Bytes(), &resp)
		              ^
api/middleware/errorscheme/middleware_test.go:102:11: Error return value of `w.Write` is not checked (errcheck)
			w.Write([]byte("Client rules, bro"))
			       ^
api/middleware/errorscheme/response.go:28:27: Error return value of `(*encoding/json.Encoder).Encode` is not checked (errcheck)
	json.NewEncoder(w).Encode(response)
	                         ^
api/middleware/errorscheme/response_test.go:22:17: Error return value of `json.Unmarshal` is not checked (errcheck)
		json.Unmarshal(w.Body.Bytes(), &resp)
		              ^
api/routes/books/books_test.go:86:28: Error return value of `(*encoding/json.Encoder).Encode` is not checked (errcheck)
		json.NewEncoder(w).Encode(map[string]string{"error": err.Message})
		                         ^
main_test.go:39:24: Error return value of `cmd.Process.Kill` is not checked (errcheck)
	defer cmd.Process.Kill()
	                      ^
api/middleware/ratelimiter/ratelimiter.go:127:2: field `allowed` is unused (unused)
	allowed  uint64
	^
api/middleware/errorscheme/middleware.go:107:21: S1002: should omit comparison to bool constant, can be simplified to `!wrapper.written` (gosimple)
			if err != nil && wrapper.written == false {
			                 ^
api/middleware/ratelimiter/ratelimiter.go:185:13: S1024: should use time.Until instead of t.Sub(time.Now()) (gosimple)
	resetIn := c.createdAt.Add(store.eviction).Sub(time.Now()).Seconds()
	           ^
main_test.go:67:2: ineffectual assignment to err (ineffassign)
	err = cmd.Wait()
	^
main.go:85:59: SA1016: syscall.SIGKILL cannot be trapped (did you mean syscall.SIGTERM?) (staticcheck)
	signal.Notify(signalCh, syscall.SIGINT, syscall.SIGTERM, syscall.SIGKILL)
	                                                         ^
```

