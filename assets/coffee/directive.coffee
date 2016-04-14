ajiApp.directive 'backImg', () ->
  return (scope, element, attrs) ->
    attrs.$observe 'backImg', (value) ->
      url = attrs.backImg
      element.css({
        'background-image': 'url(' + url + ')'
      })

ajiApp.directive 'inAppLink', () ->
  return (scope, element, attrs) ->
    attrs.$observe 'inAppLink', (value) ->
      url = attrs.inAppLink
      element.unbind 'click'
      element.on 'click', (e) ->
        cordova.InAppBrowser.open(url, '_system', 'location=yes')
