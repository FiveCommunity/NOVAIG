$(function (){
    var actionContainer = $("#actionmenu");

    window.addEventListener('message',function(event){
        var data = event.data;

        if (data.showmenu){
            $("#botoes").empty()
            $("#andar").html("<p id='numeroandar'> "+ data.andar +" </p>");

            let andares = data.elevador
            for (let item in andares) {
                $("#botoes").append(`
                    <button id="botaoEsquerda" onclick="setFloorNumber('${data.tipo}', '${item}') ">${item}</button>
                  `)
            }

            actionContainer.show();
        }

        if (data.hidemenu){
            actionContainer.hide();
        }
    });

    document.onkeyup = function(data){
        if (data.which == 27){
            if (actionContainer.is(":visible")){
                actionContainer.hide();
                $.post('http://mirtin_snippets/closeNui',JSON.stringify({}))
            }
        }
    };

})

//Botões
function setFloorNumber(nameElevador, floorNumber){
    var audio = new Audio();
    audio.src = "sounds/click.ogg";
    audio.play();
    $("#andar").html("<p id='numeroandar'>" + floorNumber + "</p>");

    $.post('http://mirtin_snippets/elevadorInit', JSON.stringify({
        elevador: nameElevador,
        andar: floorNumber
    }))
};