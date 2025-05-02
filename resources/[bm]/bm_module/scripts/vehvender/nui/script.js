$(document).ready(function () {
    requestMyCars()
})

var selectedVehicleSell = ''
var selectedVehicleKey = ''
function requestMyCars(){
    $.post("http://bm_module/requestMyCars", JSON.stringify({}), (data)=>{
        $('.result_cars_veh').html('')
        data.list.map((item, index)=>{
            $('.result_cars_sell').append(`
                <div class="item_cars_veh" data-index="${item.vehicle}" data-name="${item.nome}" onclick="selectVehicle('sell','${item.vehicle}', '${item.nome}')">
                    ${item.nome.toUpperCase()}
                </div>
            `)
            $('.result_cars_key').append(`
                <div class="item_cars_veh" data-index="${item.vehicle}" data-name="${item.nome}" onclick="selectVehicle('key','${item.vehicle}', '${item.nome}')">
                    ${item.nome.toUpperCase()}
                </div>
            `)

        })
        
    });
}

function openModal(key){
    if(key == 'sell' && !$('.result_cars_sell').is('visible')) $('.result_cars_sell').fadeIn()
    if(key == 'sell' && $('.result_cars_sell').is('visible')) $('.result_cars_sell').fadeOut()

    if(key == 'key' && !$('.result_cars_key').is('visible')) $('.result_cars_key').fadeIn()
    if(key == 'key' && $('.result_cars_key').is('visible')) $('.result_cars_key').fadeOut()
}

function selectVehicle(type, index, name){
    if(type == 'sell'){
        $('.name_car_sell').html(name.toUpperCase())
        $('.result_cars_sell').fadeOut()
        selectedVehicleSell = index
    }

    
    if(type == 'key'){
        $('.name_car_key').html(name.toUpperCase())
        $('.result_cars_key').fadeOut()
        selectedVehicleKey = index
    }
}


function sellVehicle(type){
    
    if(type == 'sell'){
        $.post("http://bm_module/SendVehicleSell", JSON.stringify({
            type,
            index: selectedVehicleSell,
            value: $('.value_veh_sell').val(),
            id: $('.id_veh_sell').val()

        }), (data)=>{});   
    }

    
    if(type == 'keyAdd' || type == 'keyRem'){
        $.post("http://bm_module/SendVehicleSell", JSON.stringify({
            type,
            index: selectedVehicleKey,
            id: $('.id_key_veh').val()
        }), (data)=>{});
    }

    
}