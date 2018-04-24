<?php

namespace CrazyLister\Serverless;

class PrintHelloWorld implements \Raines\Serverless\Handler
{
    public function handle(array $event, \Raines\Serverless\Context $context)
    {
        $logger = $context->getLogger();
        $logger->notice('Got event', $event);

        return [
            'statusCode' => 200,
            'body' => 'Your PHP code was running successfully with Redis or any desired library!',
        ];
    }
}
