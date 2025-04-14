## GWY/CI by @earcamone
  
 - `   DATE`: 2025-04-14 23:07:25
 - `    RUN`: MANUAL
 - ` BRANCH`: feature/no-ref/final-modular-ci-dependencies-fix
 - `VERSION`: 1.23.4
 - `TIMEOUT`: 300
  
## Vulnerabilities Scan

[GO-2025-3563](https://pkg.go.dev/vuln/GO-2025-3563)
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L71): `gapi.main calls http.Server.ListenAndServe, which eventually calls internal.chunkedReader.Read`

[GO-2025-3447](https://pkg.go.dev/vuln/GO-2025-3447)
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L71): `gapi.main calls http.Server.ListenAndServe, which eventually calls nistec.P256Point.ScalarBaseMult`
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L71): `gapi.main calls http.Server.ListenAndServe, which eventually calls nistec.P256Point.ScalarMult`
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L85): `gapi.WaitForShutdown calls signal.Notify, which eventually calls nistec.P256Point.SetBytes`

[GO-2025-3373](https://pkg.go.dev/vuln/GO-2025-3373)
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L85): `gapi.WaitForShutdown calls signal.Notify, which eventually calls x509.CertPool.AppendCertsFromPEM`
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L71): `gapi.main calls http.Server.ListenAndServe, which eventually calls x509.Certificate.Verify`
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L71): `gapi.main calls http.Server.ListenAndServe, which eventually calls x509.Certificate.VerifyHostname`
 - [ratelimiter.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/api/config/ratelimiter.go#L144): `config.TotalHitsPolicy calls fmt.Sprintf, which eventually calls x509.HostnameError.Error`
 - [main.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix/main.go#L85): `gapi.WaitForShutdown calls signal.Notify, which eventually calls x509.ParseCertificate`


## Vulnerabilities Scan Output

```

Vulnerability #1: GO-2025-3563
    Request smuggling due to acceptance of invalid chunked data in net/http
  More info: https://pkg.go.dev/vuln/GO-2025-3563
  Standard library
    Found in: net/http/internal@go1.23.4
    Fixed in: net/http/internal@go1.23.8
    Example traces found:
      #1: main.go:71:31: gapi.main calls http.Server.ListenAndServe, which eventually calls internal.chunkedReader.Read

Vulnerability #2: GO-2025-3447
    Timing sidechannel for P-256 on ppc64le in crypto/internal/nistec
  More info: https://pkg.go.dev/vuln/GO-2025-3447
  Standard library
    Found in: crypto/internal/nistec@go1.23.4
    Fixed in: crypto/internal/nistec@go1.23.6
    Platforms: ppc64le
    Example traces found:
      #1: main.go:71:31: gapi.main calls http.Server.ListenAndServe, which eventually calls nistec.P256Point.ScalarBaseMult
      #2: main.go:71:31: gapi.main calls http.Server.ListenAndServe, which eventually calls nistec.P256Point.ScalarMult
      #3: main.go:85:15: gapi.WaitForShutdown calls signal.Notify, which eventually calls nistec.P256Point.SetBytes

Vulnerability #3: GO-2025-3373
    Usage of IPv6 zone IDs can bypass URI name constraints in crypto/x509
  More info: https://pkg.go.dev/vuln/GO-2025-3373
  Standard library
    Found in: crypto/x509@go1.23.4
    Fixed in: crypto/x509@go1.23.5
    Example traces found:
      #1: main.go:85:15: gapi.WaitForShutdown calls signal.Notify, which eventually calls x509.CertPool.AppendCertsFromPEM
      #2: main.go:71:31: gapi.main calls http.Server.ListenAndServe, which eventually calls x509.Certificate.Verify
      #3: main.go:71:31: gapi.main calls http.Server.ListenAndServe, which eventually calls x509.Certificate.VerifyHostname
      #4: api/config/ratelimiter.go:144:20: config.TotalHitsPolicy calls fmt.Sprintf, which eventually calls x509.HostnameError.Error
      #5: main.go:85:15: gapi.WaitForShutdown calls signal.Notify, which eventually calls x509.ParseCertificate

Your code is affected by 3 vulnerabilities from the Go standard library.
This scan also found 1 vulnerability in packages you import and 0
vulnerabilities in modules you require, but your code doesn't appear to call
these vulnerabilities.
```

