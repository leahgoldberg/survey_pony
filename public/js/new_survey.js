$('document').ready(function(){

  $("#new-survey").on("submit", function(e) {
    e.preventDefault();
    $this = $(this);
    $.ajax({
      url: $this.attr('action'),
      data: $this.serialize(),
      method: $this.attr('method')
    }).done(function(response){
      $('#new-survey-form').remove();
      $('#add-questions-div').append(response);
    }).fail(function() {
      console.log("Didn't add new survey correctly")
    });
  });

  $("#add-questions-div").on("submit", "#add-question",function(e){
    e.preventDefault();
    $this = $(this);
    $.ajax({
      url: $this.attr('action'),
      data: $this.serialize(),
      method: $this.attr('method')
    }).done(function(response){
      $('#add-choice-div').append(response);
      $('#finish-survey-form').toggle();
      $('#question-submit').hide();
    }).fail(function() {
      console.log("Didn't add new question correctly")
    });

    $('#add-choice-div').on('submit','#new-choice', function(e){
      e.preventDefault();
      $this = $(this);
      $.ajax({
        url: $this.attr('action'),
        data: $this.serialize(),
        method: $this.attr('method')
      }).done(function(response){
        $('#new-choice').remove();
        $('#finish-survey-form').hide();
        $('#add-question').replaceWith(response);
        $('#question-submit').show();
      }).fail(function() {
        console.log("Didn't add new choices correctly")
      });
    });
  });

  $("#finish-survey").on("submit", function(e){
    e.preventDefault();
    $this = $(this)
    $choices = $this.parent().parent().find("#new-choice");
    $.ajax({
      url: $choices.attr('action'),
      data: $choices.serialize() + "&" + $this.serialize(),
      method: $choices.attr('method')
    }).done(function(response){
      $("#create-new-survey").replaceWith(response);
    }).fail(function() {
      console.log("Didn't submit survey properly")
    });
  });
});