//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

(function(){
  $(document).ready(function(){
    $('.datepicker').datepicker({
      format: 'dd/mm/yyyy',
    })  
  })
})()

var ticket_data = ticket_types.length > 0 ? ticket_types : [{
  name: 'Early Bird 1',
  price: 100000,
  max_quantity: 10
},{
  name: 'Normal Bird',
  price: 500000,
  max_quantity: 5
}]

var event_form = new Vue({
  el: "#new_events",
  data: {
    ticket_types: ticket_data,
    should_create: !venue
  },
  methods: {
    addTicket: function(e) {
      e.preventDefault();
      console.log(this.ticket_types)
      this.ticket_types.push({
        name: '',
        price: 0,
        max_quantity: 0
      });
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