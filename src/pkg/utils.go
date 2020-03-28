package pkg

import (
	"strings"
)

func SplitStringParameter(parameterValue string, separator string) []string {
	return strings.Split(parameterValue, separator)
}
