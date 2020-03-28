package cmd

import (
	"flag"
	"my-organization/my-app/pkg"

	logging "github.com/hhkbp2/go-logging"
)

const applicationName = "my-app"

const loggingFormat := "%(asctime)s %(levelname)s (%(filename)s:%(lineno)d) %(name)s %(message)s"
const loggingDateFormat := "%Y-%m-%d %H:%M:%S.%3n"

const parameterValueSeparatorCharacter = ","

const inputStringParameterName = "input-string"

var (
	inputString = flag.String(inputStringParameterName, "", "A sample input string. (Required)")
)

func main() {

	flag.Parse()

	logger := logging.GetLogger(applicationName)
	handler := logging.NewStdoutHandler()
	formatter := logging.NewStandardFormatter(loggingFormat, loggingDateFormat)
	handler.SetFormatter(formatter)
	logger.SetLevel(logging.LevelInfo)
	logger.AddHandler(handler)

    logger.Infof("Application configuration:")
        logger.Infof("    %s: %s", inputStringParameterName, *inputString)

	for _, inputStringPart := range pkg.SplitStringParameter(*inputString, parameterValueSeparatorCharacter) {
		logger.Infof("Parsed input value: %s", inputStringPart)
	}
}
