// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

var fade_flash = function(){
    $("#flash-notice").delay(5000).fadeOut("slow");
};
fade_flash();

var show_ajax_message = function(msg, type) {
    var my_class = "";
    var close = "";
    if(type === "notice")
        my_class = "success";
    else {
        close = '<button type="button" class="close" data-dismiss="alert">&times;</button>';
        my_class = type;
    }

    $("#flash-message").hide().html(
        '<div id="flash-'+type+'" class= "alert alert-'+ my_class +'">' +
            close +
            msg +
        '</div>'
    ).fadeIn();
    fade_flash();
};

$("#flash-message").ajaxComplete(function(event, request){
    var msg = request.getResponseHeader('X-Message');
    var type = request.getResponseHeader('X-Message-Type');
    if(msg !== null && type !== null){
        show_ajax_message(msg, type);
    }
});