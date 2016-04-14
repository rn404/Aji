app = new Framework7({
  preprocess: (content,url,next)->
    uri = parseUri(url)
    return content if uri.file is "index.html"
    body = angular.element(document.querySelector('.view-main'))
    $injector = body.injector()
    $timeout = $injector.get('$timeout')
    matches = content.match(new RegExp("ng-controller=\"[^\"]+\"", "g"))
    if matches isnt null
      $timeout ()->
        for match in matches
          try
            $compile = $injector.get("$compile")
            divs = document.querySelectorAll("div[#{match}]")
            addedDiv = angular.element(divs[divs.length-1])
            $scope = addedDiv.scope()
            continue if !$scope?
            $compile(addedDiv)($scope)
            $scope.$apply()
          catch e
            console.error(e)
            console.error("Error while executing $f7-preprocess")
      , 5

    return content
})

$$ = Dom7
mainView = app.addView('.view-main', {dynamicNavbar: true})

ajiApp.service "$f7", () ->
  {
    $app: app
    $mainView: mainView
  }

