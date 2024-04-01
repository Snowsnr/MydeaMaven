/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


let slider_lmn = document.getElementById('slider_lmn');
let slider_dtp = document.getElementById('slider_dtp');
let divs_pro = document.querySelectorAll('.card_pro_most');
let botones_most_pro = document.querySelectorAll('.btns_pro_most');
let pro_most_info = document.getElementById("Prod_most_espe_cont1");
let pro_most_res = document.getElementById("Prod_most_espe_cont2");
let IDP = document.getElementById("IDP");
let divEspecifico = document.getElementById('producto_epecifico');
let sin_like = document.getElementById("h_sc");
let con_like = document.getElementById("h_cc");
let slider_cup = document.getElementById("res_otr_usu");
let link_my = document.getElementById("link-contact");

document.getElementById('prev_lmn').addEventListener('click', function () {
    slider_lmn.scrollBy({left: -645, behavior: 'smooth'});
});

document.getElementById('next_lmn').addEventListener('click', function () {
    slider_lmn.scrollBy({left: 645, behavior: 'smooth'});
});

document.getElementById('prev_dtp').addEventListener('click', function () {
    slider_dtp.scrollBy({left: -645, behavior: 'smooth'});
});

document.getElementById('next_dtp').addEventListener('click', function () {
    slider_dtp.scrollBy({left: 645, behavior: 'smooth'});
});

divs_pro.forEach(function (div) {
    div.addEventListener('click', function () {
        copiarDatos(this);
    });
});

function copiarDatos(divClicado) {
    let nombre = divClicado.querySelector("#tt_pro_most").textContent;
    let precio = divClicado.querySelector("#pre_most_pro").textContent;
    let descripcion = divClicado.querySelector("#desc_com_pro").textContent;
    let disponibilidad = divClicado.querySelector(".dis_most_pro").value;
    let destinoDiv = document.getElementById('producto_epecifico');
    let img = divClicado.querySelector("#card-img-top").src;
    destinoDiv.style.display = "flex";
    destinoDiv.querySelector("#npv_pro_esp").textContent = nombre;
    destinoDiv.querySelector("#pre_pro_esp").textContent = "$" + precio;
    destinoDiv.querySelector("#des_pro_esp").textContent = descripcion;
    destinoDiv.querySelector("#dis_pro_esp").textContent = disponibilidad;
    destinoDiv.querySelector("#img_pro_mosr_espe").src = img;
}


//CAMBIAR EL COLOR DE LOS BOTONES DE LOS PRODUCTO
IDP.addEventListener("click", () => {
    pro_most_info.style.display = "flex";
    pro_most_res.style.display = "none";
});

botones_most_pro.forEach(function (boton) {
    boton.addEventListener('click', function () {
        botones_most_pro.forEach(function (b) {
            b.classList.remove('bpmer_active');
        });

        boton.classList.add('bpmer_active');
    });
});

divEspecifico.addEventListener("click", (e) => {
    if (e.target === divEspecifico) {
        divEspecifico.style.display = "none";
    }
});

var textoParaCopiar = link_my.getAttribute("data-bs-title");


link_my.addEventListener("click", () => {
    navigator.clipboard.writeText(textoParaCopiar).then(function () {
        Swal.fire({
            title: "DIRECCIÓN COPIADA EN PORTAPAPELES",
            text: "Dirección copiado: " + textoParaCopiar,
            icon: "success",
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true
        });
    });
});