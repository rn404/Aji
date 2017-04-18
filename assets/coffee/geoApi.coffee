ajiApp.factory 'GeoApi', ['$resource', '$http', '$q', ($resource, $http, $q) ->
  class GeoApi
    getNearPoint: (coords, start = 0) ->
      deffered = $q.defer()
      $http.jsonp CONST.GNAV_SEARCH_API,{
        timeout: 5000
        params:
          keyid: CONST.GNAV_SEARCH_KEY
          format: 'json'
          latitude: coords.latitude
          longitude: coords.longitude
          hit_per_page: 100
          range: 1
          callback: 'JSON_CALLBACK'
      }
        .success (res) ->
          deffered.resolve(res)
        .error (res) ->
          deffered.reject(res)
      return deffered.promise

  return GeoApi
]
