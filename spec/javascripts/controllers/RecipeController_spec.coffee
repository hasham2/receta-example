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
      scope = $routeParams.$new()
      location = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.recipeId = recipeId
      
      ctrl = $controller("RecipeController", $scope: scope)
    )

  beforeEach(module("receta"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()
