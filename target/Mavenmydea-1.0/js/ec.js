/*

Tel.addEventListener("click", () => {
    let tel_inp = document.getElementById("inpt_tel");
    inps_edp.forEach(function (inpts) {
        inpts.style.display = "none"
    });
    var estiloDisplay = tel_inp.display;
    alert(estiloDisplay);
    if (estiloDisplay == 'flex') {
        alert("ahí va un none");
        tel_inp.style.display = "none";
    } else {
        tel_inp.style.display = "flex";
        alert("ahí va un flex");
    }
});*/


let FORM_CNF = document.getElementById("forme");
let Btn_S = document.getElementById("btnsubmit");
const img3 = document.getElementById('inpt_file_img_perf');
let IMG3 = document.getElementById('foto');

const CLOUDINARY_URL = `https://api.cloudinary.com/v1_1/digt8oaow/image/upload`;
const CLOUDINARY_UPLOAD_PRESET = 'oxfoqolm';


Btn_S.addEventListener('click', async (e) => {
    if(img3.files.length!==0){
    event.preventDefault();
    const file = img3.files[0];
    const formData = new FormData();
    formData.append('file', file);
    formData.append('upload_preset', CLOUDINARY_UPLOAD_PRESET);

    // Send to cloudianry
    const res = await axios.post(
        CLOUDINARY_URL,
        formData,
        {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
           
        }
    );

    IMG3.value = res.data.secure_url;
    }else{
    console.log("Hola "+img3.files);
} 
});


Btn_S.addEventListener("click", (event) => {
  event.preventDefault();
  Swal.fire({
    title: "¿Está seguro de actualizar estos datos?",
    text: "Una vez confirme su cuenta sera actualizada (Puede editar los datos nuevamente despues).",
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


let Tel = document.getElementById("Telefono");
let Ema = document.getElementById("Email");
let Face = document.getElementById("Facebook");
let Inst = document.getElementById("Instagram");
let Twit = document.getElementById("Twitter");
let Web = document.getElementById("Web");
let confirm = document.getElementsByClassName("bi-check-circle");
let sections = document.getElementsByClassName("inpt_ing_cont");
let nue_img = document.getElementById("nimg_most");
let inpt_file_img_perf = document.getElementById("inpt_file_img_perf");
let icon_img_most = document.getElementById("icon_img_most");


document.addEventListener('DOMContentLoaded', function () {
    let inpt_tel = document.getElementById('inpt_tel');
    let inpt_ema = document.getElementById('inpt_ema');
    let inpt_face = document.getElementById('inpt_face');
    let inpt_inst = document.getElementById('inpt_inst');
    let inpt_twit = document.getElementById('inpt_twit');
    let inpt_web = document.getElementById('inpt_web');

    Tel.addEventListener('click', function () {
        toggleDisplay(inpt_tel);
    });
    Ema.addEventListener('click', function () {
        toggleDisplay(inpt_ema);
    });
    Face.addEventListener('click', function () {
        toggleDisplay(inpt_face);
    });
    Inst.addEventListener('click', function () {
        toggleDisplay(inpt_inst);
    });
    Twit.addEventListener('click', function () {
        toggleDisplay(inpt_twit);
    });
    Web.addEventListener('click', function () {
        toggleDisplay(inpt_web);
    });

    for (let i = 0; i < confirm.length; i++) {
        confirm[i].addEventListener('click', function () {
            for (let i = 0; i < sections.length; i++) {
                sections[i].style.display = "none";
            }
        });
    }
});

function toggleDisplay(elemento) {
    var estiloDisplay = window.getComputedStyle(elemento).display;
    if (estiloDisplay === 'none') {
        for (let i = 0; i < sections.length; i++) {
            sections[i].style.display = "none";
        }
        elemento.style.display = 'flex';
    } else {
        elemento.style.display = 'none';
    }
}

document.addEventListener('DOMContentLoaded', (event) => {
    inpt_file_img_perf.addEventListener('change', function(e) {
        var archivo = e.target.files[0];
        var tiposPermitidos = /(\.jpg|\.jpeg|\.png)$/i;

        if(!tiposPermitidos.exec(archivo.name)) {
            Swal.fire({
                title: "ERROR",
                text: "Por favor, sube solo archivos .jpg o .png.",
                icon: "error",
                showConfirmButton: true
            });
            e.target.value = '';
            nue_img.src = ''; // Borra la previsualización de la imagen
            return false;
        } else {
            showPreviewImage(e); // Si es una imagen, muestra la previsualización
        }
    });

    icon_img_most.addEventListener("click", function () {
        inpt_file_img_perf.click();
    });

    function showPreviewImage(event) {
        nue_img.style.display = "flex";
        icon_img_most.style.position = "absolute";
        const file = event.target.files[0];
        const reader = new FileReader();

        reader.onload = function (event) {
            nue_img.src = event.target.result;
        };

        if (file) {
            reader.readAsDataURL(file);
        }
    }
});

