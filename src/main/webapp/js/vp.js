/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


let FORM_CNF = document.getElementById("forme");
let Btn_S = document.getElementById("btnsubmit");
let contador = document.getElementById("contador");

for (var i = 0; i < contador.value; i++) {
    var s = "forme"+i;
    var s2 = "btnsubmit"+i;
    let FORM_CNF = document.getElementById(s);
    let Btn_S = document.getElementById(s2);
    console.log(s);
      Btn_S.addEventListener("click", (event) => {
      event.preventDefault();
      Swal.fire({
        title: "¿Está seguro de eliminar este negocio?",
        text: "Una vez confirme su negocio no será visible.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "rgba(244, 55, 112, 0.8)",
        cancelButtonColor: "#971A40",
        confirmButtonText: "Aceptar",
        cancelButtonText: "Cancelar"
      }).then((result) => {
        if (result.isConfirmed) {


             FORM_CNF.submit();

        }
      });
    });
}

