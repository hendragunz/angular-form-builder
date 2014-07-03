@FormEntryCtrl = ["$scope", "$timeout", ($scope, $timeout) ->

  # Add row question group
  $scope.addRowQuestionGroup = (a) ->
    partial = row_question_group.replace(/UNIQUE_ID/g, $scope.unique_id())
    $('.question-group-rows', $scope).append partial
    return


  # remove row question group
  $scope.removeRowQuestionGroup = (row_question_group)->
    $scope.row_question_groups.splice( $scope.row_question_groups.indexOf(row_question_group), 1 )

  # will return unique_id
  $scope.unique_id = () ->
    (new Date()).getTime()

  angular.element(document).ready () ->
    # TO DO
    # console.log 'yay!!!'
]