ajiApp.service 'GenerateMap', () ->
  class GenerateMap
    OVERLAY_ACTIVE_CLASS = 'status-load'
    buildMapElement = (element, point) ->
      ops = {
        center: point
        zoom: 16
        draggable: true
        zoomControl: true
        scaleControl: true
        streetViewControl: false
        mapTypeControl: false
        scrollwheel: false
      }
      return new google.maps.Map(element, ops)

    buildMapPoint = (latitude, longitude) ->
      _lat = latitude - 0
      _lng = longitude - 0
      return new google.maps.LatLng(_lat, _lng)

    buildMapMarker = (map, point) ->
      return new google.maps.Marker({
        map: map
        position: point
      })

    buildService = (map) ->
      return new google.maps.places.PlacesService(map)

    constructor: (element, current, attr) ->
      # initialize
      @.markers = {}
      @.current = buildMapPoint(current.latitude, current.longitude)
      @.map = buildMapElement(element, @.current)

      @.markers.current = buildMapMarker(@.map, @.current)

      @.service = buildService(@.map)

      @.setOverlay = () ->
        angular.element(element).addClass(OVERLAY_ACTIVE_CLASS)

      @.removeOverlay = () ->
        angular.element(element).removeClass(OVERLAY_ACTIVE_CLASS)

      _self = @
      google.maps.event.addListener(@.map, 'center_changed', () ->
        # _self.removeOverlay()

        if _self.markers.targetBefore
          _self.markers.targetBefore.setMap(null)
          _self.markers.targetBefore = null
      )

      @.generateMap(attr)

    generateMap: (attr) ->
      _request = {
        location: @.current
        keyword: attr.address
        name: attr.name
        radius: 2000
      }
      # @.setOverlay()

      _self = @
      @.service.nearbySearch _request, (result, status) ->
        if status == google.maps.places.PlacesServiceStatus.OK
          console.log result
          _targetPoint = result[0].geometry.location
          _self.markers.targetBefore = _self.markers.target
          _self.markers.target = buildMapMarker(_self.map, _targetPoint)
          _self.map.panTo(_targetPoint)
          _self.map.setOptions({ zoom: 16 })
          # TODO: 0件だったときのケース

  return GenerateMap
