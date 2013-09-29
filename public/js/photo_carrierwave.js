$(document).ready(function() {
    $('#edit_image').click(function(event) {
        event.preventDefault();
        $(this).hide();

        $.get($(this).attr("href"), function(form) {
            $('h1').after(form);
        })
    })        
});