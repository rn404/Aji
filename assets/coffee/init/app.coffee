window.ajiApp = angular.module("AjiApp", ["ngCordova",'ngStorage','ngAnimate','ngCookies','ngResource','ngRoute', 'ngSanitize', "uiGmapgoogle-maps"])

onDeviceReady = () ->
  window.open = cordova.InAppBrowser.open
document.addEventListener('deviceready', onDeviceReady, false)

