let mneg_nav = document.getElementById("btn_neg_nav");
let mneg_nav2 = document.getElementById("btn_neg2_nav");


let fbk_nav = document.getElementById("btn_fbk_nav");
let sb_nav = document.getElementById("btn_sb_nav");


mneg_nav.addEventListener("click", ()=>{
    window.location.href = "Vendedor_Perfil.jsp";
});

mneg_nav2.addEventListener("click", ()=>{
    window.location.href = "Vendedor_Perfil.jsp";
});


fbk_nav.addEventListener("click", ()=>{
    window.location.href = "Feedback.jsp";
});

sb_nav.addEventListener("click", () => {
    window.location.href = "CrearNegocio_Info.jsp";
});

let count_n = document.getElementById("btn_count_nav");
let count2_n = document.getElementById("btn_count2_nav");
let edt_n = document.getElementById("btn_edit_nav");
let sav_n = document.getElementById("btn_sav_nav");
let sav2_n = document.getElementById("btn_sav2_nav");
let res_n = document.getElementById("btn_res_nav");
let lgout_n = document.getElementById("btn_lgout_nav");
let fomr = document.getElementById("formcerrar");



count_n.addEventListener("click", () => {
    window.location.href = "Cuenta_Vendedor.jsp";
});

count2_n.addEventListener("click", () => {
    window.location.href = "Cuenta_Vendedor.jsp";
});

edt_n.addEventListener("click", () => {
    window.location.href = "Editar_CuentaCV.jsp";
});

sav_n.addEventListener("click", () => {
    window.location.href = "GuardadosCV.jsp";
});

sav2_n.addEventListener("click", () => {
    window.location.href = "GuardadosCV.jsp";
});

res_n.addEventListener("click", () => {
    window.location.href = "Comentarios_HechosCV.jsp";
});

lgout_n.addEventListener("click", (event) => {
     event.preventDefault();
    Swal.fire({
        title: "¿Está seguro de cerrar sesión?",
        text: "Una vez que cierre sesión, deberá volver a iniciar sesión para acceder.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "rgba(244, 55, 112, 0.8)",
        cancelButtonColor: "#971A40",
        confirmButtonText: "Aceptar",
        cancelButtonText: "Cancelar"
    }).then((result) => {
        if (result.isConfirmed) {
            fomr.submit();
        }
    });
});