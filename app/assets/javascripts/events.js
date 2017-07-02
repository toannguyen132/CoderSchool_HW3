//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

(function(){
  $(document).ready(function(){
    $('.datepicker').datepicker({
      format: 'dd/mm/yyyy',
    })  
  })

  if ($('#new_events').length > 0){
    console.log(JSON.parse(ticket_types));

    var event_form = new Vue({
      el: "#new_events",
      data: {
        ticket_types: JSON.parse(ticket_types),
        should_create: venue > 0
      },
      methods: {
        addTicket: function(e) {
          e.preventDefault();
          _.forEach(this.ticket_types, function(t){
            console.log(t)
          })
          this.ticket_types.push({
            name: '',
            price: 0,
            max_quantity: 0
          });
        },
        removeTicket: function(i){
          _.pullAt(this.ticket_types, [i])
          this.ticket_types.splice(i, 0)
        },
        venueUpdate: function(e){
          if (!e.target.value){
            this.should_create = true
          } else {
            this.should_create = false
          }
        }
      }
    })
  }
})()

