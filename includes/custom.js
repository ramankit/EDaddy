$(document).ready( function() {

    $("#prompt_alert").click( function() {
        jPrompt('Your Name:', 'Type name here', 'What is your name?', function(r) {
            if( r ) alert('You name is: ' + r);
        });
    });

});