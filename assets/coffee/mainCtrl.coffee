STATUS =
  IDLING: 'idling'
  LOADING: 'loading'
  SEARCH: 'search'
  RESULT: 'result'

ajiApp.controller 'MainCtrl', ['$scope', '$rootScope', '$f7', 'GeoApi', 'GenerateMap', ($scope, $rootScope, $f7, GeoApi, GenerateMap) ->
  $scope.status = STATUS.IDLING
  geoApi = new GeoApi

  getRandomId = () ->
    # 0-99のrandom数値を返す
    max = 100
    rand = Math.floor(Math.random() * max)
    return rand

  trimPointData = (data) ->
    res = {
      name: data.name
      budget: data.budget
      category: data.category || null
      pr: data.pr.pr_short || null
      address: data.address || null
      tel: data.tel || null
      holiday: data.holiday || null
      opentime: data.opentime || null
      image_url: data.image_url.shop_image1 || null
      url: data.url_mobile
    }

    # ないやつをなぜか空のObjectで返してくるので正規化, マジ迷惑
    for key of res
      _tmp = res[key]
      tmp = if Object.keys(_tmp).length == 0 then null else _tmp
      res[key] = tmp

    return res

  getLocalData = (coords) ->
    geoApi.getNearPoint(coords)
      .then (data) ->
        console.log data
        $scope.localList = data.rest
        $scope.getLocalPoint()
      , (err) ->
        console.log 'error', err
        $f7.$app.alert('取得することができませんでした。再度お試し下さい')

  setStatus = (status) ->
    resetStatus()
    $scope.status[status] = true
    console.log 'STATUS: ', status, $scope.status

  resetStatus = () ->
    for status of STATUS
      _status = status.toLowerCase()
      $scope.status[_status] = false

  initializeData = () ->
    $scope.point = null
    $scope.localList = null
    $scope.map = null

  scrollToTop = () ->
    $('.page-content').scrollTop(0)

  $scope.toSearch = () ->
    initializeData()
    setStatus(STATUS.SEARCH)

  $scope.status = {}

  $scope.init = () ->
    setStatus(STATUS.SEARCH)
    console.log 'app controll init'

  $scope.getCurrentGeolocation = () ->

    geolocationSuccess = (position) ->
      console.log 'current', position.coords.latitude + ', ' + position.coords.longitude
      setStatus(STATUS.RESULT)
      _coords = 
        latitude: position.coords.latitude
        longitude: position.coords.longitude
      getLocalData(_coords)
      $scope.currentPosition = _coords

    geolocationError = (error) ->
      setStatus(STATUS.SEARCH)
      console.log error
      $f7.$app.alert('電波状況を確かめて再度お試し下さい')

    navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError)
    setStatus(STATUS.LOADING)

  $scope.getLocalPoint = () ->
    _randId = getRandomId()
    console.log 'random', _randId

    _point = $scope.localList[_randId]
    $scope.point = trimPointData(_point)
    console.log $scope.point

    _attr =
      address: $scope.point.address
      name: $scope.point.name

    if $scope.map
      $scope.map.generateMap(_attr)
    else
      _map = new GenerateMap(angular.element('#map')[0], $scope.currentPosition, _attr)
      $scope.map = _map

    scrollToTop()
    return


  return
]


