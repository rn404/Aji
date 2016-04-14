# Dependencies

* Xcode
* node
* cordova
* bower
* gulp
* jade
* sass

please install and update.

# Setup

```
cordova platform add browser
cordova platform add ios
brew install ios-sim
npm install
bower install
```

then get google API key and rewrite `variable.json`
```
cp variable.json.tmp variable.json
vim variable.json
# input your google api key
```

## install cordova plugins

```
cordova plugin add cordova-plugin-geolocation
cordova plugin add cordova-plugin-inappbrowser
cordova plugin add cordova-plugin-splashscreen
```

# Start

## Start up in browser
```
. bin/run
```

## Start up in iOS
```
cordova run ios
```

# Other

```
gulp
```
run default gulp tasks.
build jade template, coffee script to native javascript, scss to stylesheet.

