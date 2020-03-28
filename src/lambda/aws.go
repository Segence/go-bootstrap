package lambda

import (
	"context"
	"my-organization/my-app/cmd"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func main() {
	lambda.Start(handler)
}

func handler(ctx context.Context, event events.CloudWatchEvent) {
	cmd.Main()
}
