$(document).ready(function() {
    $('#search_responsive').click(function() {
        $("#search_responsive").css("display", "none");
        $(".boton, .logo_mobile").css("display", "none"); // Desaparecen sin animación
        $(".close_search").css("display", "flex"); // Aparecen con animación
        $("#div_buscador").css("display", "flex").animate({ // Se muestran con animación
            opacity: 1,
            left: 0
        }, 200).addClass("slide-from-right");
    });
    $('.close_search').click(function() {
        $("#search_responsive").css("display", "inline");
        $(".boton, .logo_mobile").fadeIn(200); // Aparecen con animación
        $(".close_search").fadeOut(200); // Desaparecen con animación
        $("#div_buscador").animate({ // Se ocultan con animación
            opacity: 0,
            left: '-100%'
        }, 0, function() {
            $(this).css("display", "none").removeClass("slide-from-right");
        });
    });
});