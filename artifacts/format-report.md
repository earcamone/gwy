## GWY/CI by @earcamone
  
 - `   DATE`: 2025-04-14 23:07:25
 - `    RUN`: MANUAL
 - ` BRANCH`: feature/no-ref/final-modular-ci-dependencies-fix
 - `VERSION`: 1.23.4
 - `TIMEOUT`: 300
  
## Format Scan
  - [/api/middleware/errorscheme/response_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix//api/middleware/errorscheme/response_test.go#L9)
  - [/api/middleware/errorscheme/writerwrapper_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix//api/middleware/errorscheme/writerwrapper_test.go#L6)
  - [/api/routes/books/books_test.go](https://github.com/earcamone/gapi/blob/feature/no-ref/final-modular-ci-dependencies-fix//api/routes/books/books_test.go#L33)


## Format Fix Diff Output

```
diff --git a/api/middleware/errorscheme/response_test.go b/api/middleware/errorscheme/response_test.go
index 43bb558..609fc22 100644
--- a/api/middleware/errorscheme/response_test.go
+++ b/api/middleware/errorscheme/response_test.go
@@ -9 +9 @@ import (
-	
+
diff --git a/api/middleware/errorscheme/writerwrapper_test.go b/api/middleware/errorscheme/writerwrapper_test.go
index 005be27..b3043df 100644
--- a/api/middleware/errorscheme/writerwrapper_test.go
+++ b/api/middleware/errorscheme/writerwrapper_test.go
@@ -6 +6 @@ import (
-	
+
diff --git a/api/routes/books/books_test.go b/api/routes/books/books_test.go
index aacaa21..a4521f7 100644
--- a/api/routes/books/books_test.go
+++ b/api/routes/books/books_test.go
@@ -33 +33 @@ func setupRouter(c config.Config, errFn errorscheme.ErrResponseFn) http.Handler
-	
+
```

