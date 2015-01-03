describe "RecipeController", ->
  scope       = null
  ctrl        = null
  location    = null
  routeParams = null
  resource    = null
  httpBackend = null
  recipeId    = 42

  fakeRecipe  = 
    id: recipeId
    name: "Baked Potatoes"
    instructions: "Pierce Potatoes with fork, then nuke for 20 mins"

  setupController = (recipeExists=true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller)->
      scope = $rootScope.$new()
      location = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.recipeId = recipeId
      
      request = new RegExp("\/recipes/#{recipeId}")
      results = if recipeExists
        [200, fakeRecipe]
      else
        [404]

      httpBackend.expectGET(request).respond(results[0],results[1])
      
      ctrl = $controller("RecipeController", $scope: scope)
    )

  beforeEach(module("receta"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()


  describe 'controller init', ->
    describe 'recipe is found', ->
      beforeEach(setupController())

      it 'loads the given recipe', ->
        httpBackend.flush()
        expect(scope.recipe).toEqualData(fakeRecipe)
    describe 'recipe is not found', ->
      beforeEach(setupController(false))

      it 'does not load the given recipe', ->
        httpBackend.flush()
        expect(scope.recipe).toBe(null)
