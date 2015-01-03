describe "RecipesController", ->
  scope       = null
  ctrl        = null
  location    = null
  routeParams = null
  resource    = null
  
  httpBackend = null
  
  setupController =(keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      routeParams = $routeParams
      routeParams.keywords = keywords
      resource    = $resource
      
      httpBackend = $httpBackend
      
      if results
        request = new RegExp("\/recipes.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('RecipesController', $scope: scope, $location: location)
    )
  
  beforeEach(module("receta"))
  beforeEach(setupController())
  
  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()
  
  describe 'controller initialization', ->
    describe 'when no keywords are present', ->
      
      beforeEach(setupController())
      
      it 'defaults to no recipes', ->
        expect(scope.recipes).toEqualData([])
  
  describe 'with keywords', ->
    keywords = 'foo'
    recipes = [
      {id: 1, name: 'Baked Potatoes w/ Cheese'},
      {id: 2, name: 'Fried Salmon'}
    ]
    
    beforeEach ->
      setupController(keywords, recipes)
      httpBackend.flush()

    it 'calls the back-end', ->
      expect(scope.recipes).toEqualData(recipes)

  describe 'search()', ->
    beforeEach -> 
      setupController()
    
    it 'redirects to itself with keyword "param"', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqualData({keywords: keywords})
