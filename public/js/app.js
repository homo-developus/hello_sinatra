$(document).ready(function() {
    $("#calc").click(function(){
        $.post("calc", { expression: $("#expression").val() },
            function(result) {
                console.log(result);
                $("#result").html(result);
            });
    });
});