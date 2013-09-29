$(document).ready(function() {
    $('#edit_image').click(function(event) {
        event.preventDefault();
        $(this).hide();

        $.get($(this).attr("href"), function(form) {
            $('.photo').after(form);
        })
    })        
});