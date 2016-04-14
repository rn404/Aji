ajiApp.factory 'GeoApi', ['$resource', '$http', '$q', ($resource, $http, $q) ->
  class GeoApi
    getNearPoint: (coords, start = 0) ->
      deffered = $q.defer()
      $http.jsonp 'http://api.gnavi.co.jp/RestSearchAPI/20150630/',{
        timeout: 5000
        params:
          keyid: '1ad84384694a4327e97edc644bb6a9ed'
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
