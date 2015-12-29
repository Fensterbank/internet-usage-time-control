// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function toggle_global_netuser(sender) {
    console.log(sender);
    var flag;
    if (sender.children[0].classList.contains('fa-lock'))
        flag = true;
    else
        flag = false;

    var request = new XMLHttpRequest();
    request.open('POST', '/setting/set_netuse', true);
    request.setRequestHeader('Content-Type', 'application/json');

    request.onload = function() {
        if (request.status >= 200 && request.status < 400) {
            // Success!
            var data = JSON.parse(request.responseText);
            console.log(data)
        } else {
            console.log('fails');
            console.log(args);
            // We reached our target server, but it returned an error

        }
    };

    request.onerror = function() {
        console.log('onerror');
        console.log(args);
        // There was a connection error of some sort
    };

    request.send(JSON.stringify({flag: flag}));


}