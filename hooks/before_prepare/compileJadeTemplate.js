#!/usr/bin/env node

var execSync = require('child_process').execSync;
var fs = require('fs');

var ops_json = 'variable.json'
var jade_path = 'views/'

if( !fs.existsSync(jade_path)) {
    fs.mkdirSync(jade_path)
}
execSync("jade --out www/ " + jade_path + ' --obj ' + ops_json)
//execSync("jade --out www/ " + jade_path)

