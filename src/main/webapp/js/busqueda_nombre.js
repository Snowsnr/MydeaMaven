/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    $('#bus_admin_acc').on('keyup', function () {
        var textoBusqueda = $(this).val().toLowerCase();
        var textoBusqueda1 = $('#filtr_est').val().toLowerCase();

        $('.container_admin .busq_result').each(function () {
            var textoDiv1 = $(this).find('#inp_activo').val().toLowerCase();

            if (textoDiv1.includes(textoBusqueda1)) {
                $(this).show();
            } else if (textoBusqueda1.includes("general")) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });

        $('.container_admin .busq_result').each(function () {
            var textoDiv = $(this).find('.busqueda_nombre ').text().toLowerCase();

            if (textoDiv.includes(textoBusqueda)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
});

$(document).ready(function () {
    $('#filtr_est').on('change', function () {
        var textoBusqueda = $(this).val().toLowerCase();

        $('.container_admin .busq_result').each(function () {
            var textoDiv = $(this).find('#inp_activo').val().toLowerCase();

            if (textoDiv.includes(textoBusqueda)) {
                $(this).show();
            } else if (textoBusqueda.includes("general")) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
});