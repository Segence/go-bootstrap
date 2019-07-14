package main

import (
	"flag"
	app "my-organization/my-app"

	logging "github.com/hhkbp2/go-logging"
)

const ParameterValueSeparatorCharacter = ","

func main() {
	logger := logging.GetLogger("schema-version-collector")
	handler := logging.NewStdoutHandler()

	format := "%(asctime)s %(levelname)s (%(filename)s:%(lineno)d) " +
		"%(name)s %(message)s"
	// the format for the time part
	dateFormat := "%Y-%m-%d %H:%M:%S.%3n"
	// create a formatter(which controls how log messages are formatted)
	formatter := logging.NewStandardFormatter(format, dateFormat)
	// set formatter for handler
	handler.SetFormatter(formatter)
	logger.SetLevel(logging.LevelInfo)
	logger.AddHandler(handler)

	inputString := flag.String("input-string", "", "A sample input string. (Required)")
	flag.Parse()

	logger.Infof("Received inputString: %s", *inputString)

	for _, inputStringPart := range app.SplitStringParameter(*inputString, ParameterValueSeparatorCharacter) {
		logger.Infof("Parsed input value: %s", inputStringPart)
	}
}
