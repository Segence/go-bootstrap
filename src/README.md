Go project bootstrap
====================

A sample [Go](https://golang.org) bootstrap project.

## Building the project

Make sure the Go 1.11 (or later) is installed.

The `Makefile` contains all neccessary goals for build steps.

## Running

Simply run the application using the built executable and the mandatory parameter: `./my-app --input-string=First,Second,Third`

The application then prints the following output:

```
2018-06-06 16:09:51.138 INFO (main.go:30) schema-version-collector Received inputString: First,Second,Third
2018-06-06 16:09:51.138 INFO (main.go:33) schema-version-collector Parsed input value: First
2018-06-06 16:09:51.138 INFO (main.go:33) schema-version-collector Parsed input value: Second
2018-06-06 16:09:51.138 INFO (main.go:33) schema-version-collector Parsed input value: Third
```
