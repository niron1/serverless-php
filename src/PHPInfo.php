<?php

namespace CrazyLister\Serverless;

class PHPInfo implements \Raines\Serverless\Handler
{
    public function handle(array $event, \Raines\Serverless\Context $context)
    {
        $phpinfo = "";
        $logger = $context->getLogger();
        $logger->notice("Got event", $event);
        ob_start();
        phpinfo();
        $phpinfo .= strip_tags(ob_get_clean());
        return [
            'statusCode' => 200,
            'body' => str_replace(["'","\"","\\"], "", substr($phpinfo,0,20000))
        ];
    }
}
