var gender = '';
var social = '';

$(document).ready(function () {
    $('.input_date_registration').mask('00/00/0000');
    $('.input_phone_registration').mask('(00) 0 0000-0000')
});

function selectGender(attr){
    if(attr == 'male_registration'){
        gender = 'homem';
    }
    
    if(attr == 'female_registration'){
        gender = 'mulher';
    }

    $('.select_gender').css('fill', '#fff');
    $('.select_gender').removeClass('select_social');
    $('.'+attr).css('fill', '#F34D96');
    $('.'+attr).addClass('select_gender');
}
function selectSocial(attr){
    if(attr == 'facebook_registration'){
        social = 'Facebook'
    }
    
    if(attr == 'instagram_registration'){
        social = 'Instagram'
    }
    
    if(attr == 'tiktok_registration'){
        social = 'TikTok'
    }
    
    if(attr == 'whatsapp_registration'){
        social = 'WhatsApp'
    }
    
    if(attr == 'youtube_registration'){
        social = 'Youtube'
    }
    
    if(attr == 'friend_registration'){
        social = 'Amigo(a)'
    }

    $('.select_social').css('fill', '#fff');
    $('.select_social').removeClass('select_social')
    $('.'+attr).css('fill', '#F34D96')
    $('.'+attr).addClass('select_social')

}


function confirm(){
    let info = {
        nome: $('.input_nome_registration').val(),
        email: $('.input_email_registration').val(),
        telefone: $('.input_phone_registration').val(),
        nascimento: $('.input_date_registration').val(),
        sexo: gender,
        social: social
    }
    if(info.nome != '' && info.email != '' && info.email != '' && info.telefone != '' && info.telefone.length >= 12 && info.nascimento != ''  && info.sexo != '' && info.social != ''){
        $.post("http://bm_module/registration_infos", JSON.stringify({
            info: info
        }));
        
        $.post("http://bm_module/onClose", JSON.stringify({
            close: 'registration'
        }));
    }else{
        // ADICIONAR AVISO
    }
}