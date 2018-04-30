# serverless-php-lambda
[![serverless][badge-serverless]](http://www.serverless.com)
[![language][badge-language]](http://php.net)
[![license][badge-license]](LICENSE)

PHP for AWS Lambda via Serverless Framework using Symfony components for
dependency injection.

**Latest version is on [master][git-repo]**.

[AWS Lambda][aws-lambda-home] lets you run code without thinking about servers.
Right now you can author your AWS Lambda functions in several langauges
[natively][aws-lambda-langs], but not PHP. This project aims to provide a fully
featured shim for authoring your AWS Lambda functions in PHP.

**this fork**
is a result of the inability to deploy a fully a functional php binary with all extensions (for example redis.so), 
to the AWS Lambda.
the [original author](https://github.com/araines/serverless-php) offered to build php on a docker, 
but configuring the build is a painful progress, and finding documentation on how to do it is difficult.
after correspnding with [araines](https://github.com/araines/serverless-php/issues/14) I went on researching 
other directions, the one I liked the most was to run a true Amazon Linux machine on a VM, and install there 
whichever php features we want using **yum** :-)  everything is pre-built for Amazon servers, no need to compile 
anything.
also, thinking forward, it will be easier to install other stuff on our lambda because of the friendlyness of **yum** package manager vs
the sisyphean process of configuring and buildling php.
Another thing I needed to finetune is the paths that PHP looks for its ini files and libraries, as we
don't have control on the Lambda's system file structure, we have to set new folders for those.

**Amazon Linux VM**
from time to time you may want to run the Amazon Linux VM in order to install desired binaries,
to be pulled and deployed into the AWS Lambda. You can get the **vdi** file from the Amazon repository, 
but you may as well use the [image](https://www.dropbox.com/s/b9i85goohwwkvo6/amzn2-virtualbox-2017.12.0.20180222-x86_64.xfs.gpt.vdi.tgz?dl=0) that I have configured, already containing a sudo user, PHP and SSH to pull the binaries
with (I use SCP to pull the binaries from the Amazon Linux VM)
the login credentials are: 
u: user1
p: crazamzn


## Preview
```php
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
```


# Features
[Event Data](#Event-Data)   | [Context](#Ccontext)        | [Logging](#Logging)         | [Exceptions](#Exceptions)   | [Environment](#Environment)   | [API Gateway](#Api-Gateway)
:-------------------------: | :-------------------------: | :-------------------------: | :-------------------------: | :---------------------------: | :-------------------------:
![full][badge-support-full] | ![full][badge-support-full] | ![part][badge-support-part] | ![none][badge-support-none] | ![full][badge-support-full]   | ![full][badge-support-full]


# Usage
## Prerequisites
* [Serverless](https://serverless.com/)
* [Node](https://nodejs.org)
* [Composer](https://getcomposer.org/)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)  (only if you wish to add php extensions)
* having AWS environment variables defined: 
export AWS_ACCESS_KEY_ID=<your-key-here>
export AWS_SECRET_ACCESS_KEY=<your-secret-key-here>

Install this project:
```
git clone https://github.com/niron1/serverless-php-lambda
```


## Deploying to AWS
```
composer install -o --no-dev
serverless deploy
```

## Running locally
```
serverless invoke local -f printHelloWorld
serverless invoke local -f phpinfo
```

## Running on AWS
```
serverless invoke -f printHelloWorld
serverless invoke -f phpinfo
```

 

[badge-serverless]:   http://public.serverless.com/badges/v3.svg
[badge-language]:     https://img.shields.io/badge/language-php-blue.svg
[badge-license]:      https://img.shields.io/badge/license-MIT-orange.svg
[badge-support-full]: https://img.shields.io/badge/support-full-green.svg
[badge-support-part]: https://img.shields.io/badge/support-partial-yellow.svg
[badge-support-none]: https://img.shields.io/badge/support-none-red.svg

[aws-lambda-home]:  https://aws.amazon.com/lambda/
[aws-lambda-langs]: http://docs.aws.amazon.com/lambda/latest/dg/lambda-app.html#lambda-app-author

[git-repo]:      https://github.com/araines/serverless-php
[git-zerosharp]: https://github.com/ZeroSharp/serverless-php

[blog]: https://medium.com/@araines/serverless-php-630bb3e950f5
