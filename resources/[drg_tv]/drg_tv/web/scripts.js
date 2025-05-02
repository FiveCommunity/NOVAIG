var televisionResourceName = "drg_tv";

// Esconde a interface ao iniciar
$(document).ready(function () {
    $("body").css("display", "none");
});

// Recebe mensagem do FiveM para exibir ou ocultar a interface
window.addEventListener("message", function (event) {
    let data = event.data;

    if (data.action === "openRemote") {
        $("body").css("display", "flex").hide().fadeIn(200);
    }

    if (data.action === "closeRemote") {
        $("body").fadeOut(200, function () {
            $(this).css("display", "none");
        });
    }
});

// Fecha ao pressionar "Escape"
document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
        closeRemote();
    }
});

// Fecha o controle remoto
function closeRemote() {
    $("body").fadeOut(200, function () {
        $(this).css("display", "none");
    });
    $.post("https://" + televisionResourceName + "/closeRemote", JSON.stringify({}));
}

// Função para desligar a TV
function turnOffTV() {
    $.post("https://" + televisionResourceName + "/turnoff", JSON.stringify({}));
}

// Função para tocar vídeo a partir do input
function playVideo() {
    let videoURL = $("#videoinputtvdata").val().trim();
    if (videoURL) {
        $.post("https://" + televisionResourceName + "/playvideo", JSON.stringify({
            videourldata: videoURL
        }));
    }
}

// Função para ajustar o volume
function volumeChange(action) {
    let change = action === "increase" ? 10 : -10;
    $.post("https://" + televisionResourceName + "/volumechange", JSON.stringify({
        volumedata: change
    }));
}
