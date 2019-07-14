Go project bootstrap
====================

A sample [Go](https://golang.org) bootstrap project using the project layout of the [GB](https://getgb.io) build tool.
The functionality of this bootstrap project is strictly made for demonstration purposes only and to provide a baseline application set up.

## Building the project

Make sure the [GB build tool](https://getgb.io) is installed.

Build steps:

- `gb vendor restore`
- `gb build`

To run unit tests, use: `gb test`

## Running

Simply run the application using the built executable and the mandatory parameter: `./bin/my-app --input-string=First,Second,Third`

The application then prints the following output:

```
2018-06-06 16:09:51.138 INFO (main.go:30) schema-version-collector Received inputString: First,Second,Third
2018-06-06 16:09:51.138 INFO (main.go:33) schema-version-collector Parsed input value: First
2018-06-06 16:09:51.138 INFO (main.go:33) schema-version-collector Parsed input value: Second
2018-06-06 16:09:51.138 INFO (main.go:33) schema-version-collector Parsed input value: Third
```
