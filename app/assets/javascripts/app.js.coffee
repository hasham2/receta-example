receta = angular.module('receta', ['templates', 'ngRoute', 'ngResource', 'controllers'])
receta.config(['$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/', 
        templateUrl: "index.html"
        controller: 'RecipesController'
      )
])

recipes = [
  {id: 1, name: 'Baked Potatos w/ cheese'},
  {id: 2, name: 'Fried Salmon'},
  {id: 3, name: 'Chicken supreme pizza'}
]

controllers = angular.module('controllers', [])
controllers.controller("RecipesController", ['$scope','$routeParams', '$location', '$resource'
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)-> $location.path("/").search('keywords', keywords)
    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.recipes = recipes.filter (recipe)-> recipe.name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.recipe = []

])
