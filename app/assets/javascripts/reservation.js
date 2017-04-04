// turbolinks:load is to makes sure turbolinks work while moving on to the next page which are using datepicker. Becasue if didn't turn it on, turbolinks will crash the datepicker and it can't be use.
$( document ).on('turbolinks:load', function(){
  console.log('hi');
  $('.datepicker').datepicker({format: 'yyyy-mm-dd'});
});
