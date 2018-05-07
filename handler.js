'use strict';

var child_process = require('child_process');

module.exports.handle = (event, context, callback) => {

    process.env.PATH = `${process.env.PATH}:${process.env.LAMBDA_TASK_ROOT}`;
    // When using 'serverless invoke local' use the system PHP binary instead
    var executable = './bash'; // no arguments here!
    var php = './php';
    if (typeof process.env.PWD !== "undefined") {
        php = 'php';
        executable = 'bash';
    }

    // Build the context object data
    var contextData = {};
    Object.keys(context).forEach(function(key) {
        if (typeof context[key] !== 'function') {
            contextData[key] = context[key];
        }
    });
    // Launch PHP
    var args = `handler.php ${JSON.stringify(event)} ${JSON.stringify(contextData)}`;

    const command =['-c',`${php} ${args}`];
    var response = '';
    var env = Object.create( process.env );
    env.PHPRC = `${process.env.LAMBDA_TASK_ROOT}/phpini/php.ini`;
    env.LD_LIBRARY_PATH = `${process.env.LAMBDA_TASK_ROOT}/phplibs:${process.env.PATH}`;
    env.PHP_INI_SCAN_DIR = `${process.env.LAMBDA_TASK_ROOT}/phpini/php.d`;
    var options = {'env': env, 'stdio': ['pipe', 'pipe', 'pipe', 'pipe']};

    try {
      const child = child_process.spawnSync(executable, command , options);
      const shouldAddParenthesis = child.stdout && child.stdout.toString().length && child.stdout.toString()[0] !== '{' &&  child.stdout.toString()[0] !== '"' &&  child.stdout.toString()[0] !== "\'";
      response += (`{stdout: ${shouldAddParenthesis?"\"":""} ${child.stdout && child.stdout.toString().length ? child.stdout.toString() + (shouldAddParenthesis ? "\"" : "") : '""'}`);
      response += (`,stderr:"${child.stderr ? child.stderr.toString() : ''}"`);
      response += (`,status:"${child.status ? child.status.toString() : ''}"`);
      response += (`,signal:"${child.signal ? child.signal.toString() : ''}"}`);
    } catch (exception) {
      response += (`Process crashed! Error: ${exception}`);
    }

   callback(null, response);

};
