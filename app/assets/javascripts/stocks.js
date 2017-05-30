/* global $ */
/* global show_spinner */
/* global hide_spinner */



var init_stock_lookup;

init_stock_lookup = function(){
                                
                                /* right before the ajax submission happens */
    $('#stock-lookup-form').on('ajax:before', function(event, data, status){
        
       show_spinner();
    });
    
    
                                 /* right before the ajax submission happens */
    $('#stock-lookup-form').on('ajax:after', function(event, data, status){
        
        hide_spinner();
    });
    
    
    
    
                                /* if the ajax submission is succesful */
    $('#stock-lookup-form').on('ajax:success', function(event, data, status){
    
    $('#stock-lookup').replaceWith(data);
    
    init_stock_lookup();
    
    });

    $('#stock-lookup-form').on('ajax:error', function(event, xhr, status, error){
        hide_spinner();
        $('#stock-lookup-results').replaceWith(' ');
        $('#stock-lookup-errors').replaceWith('Stock was not found.');
    });

};



$(document).ready(function() {

init_stock_lookup();

});

