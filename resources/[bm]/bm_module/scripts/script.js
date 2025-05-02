$(document).ready(() => {
    var data_atual, detect_data = '';
    window.addEventListener("message", function ({ data }) {

        detect_data = data.action
        if (data.action && data.action.toLowerCase().includes('update') && data.action != 'updateShop') {
            data_atual = data.action
            mapSlots()
        } else {
            if (data.action && !data.action.toLowerCase().includes('update')) {
                showNui(data.action);
            }
        }

        setTimeout(function () {
            if (data.action == 'updateShop' || data.action == 'shops') {
                mapSlots(data.name, data.type)
                return
            }

            if (data.action && data.action.toLowerCase().includes('garagem')) {
                if (data.mode == 'withdraw') {
                    $('.guardar').hide();
                } else {
                    $('.guardar').show();
                }
            }
        }, 100)
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            if (detect_data != 'registration' && (detect_data != 'login')) {
                $.post("http://bm_module/onClose", JSON.stringify({
                    close: data_atual
                }));
            }
        }
    };
})

function showNui(attr) {
    if (attr == 'hideMenu') {
        window.location.reload()
        $('.container').hide();
        $('body').css('background', 'transparent');
        return
    }

    $('.container').hide();
    $('#container_' + attr).show();
    $('#container_' + attr).load(attr + '/nui/index.html');
    $('#general').attr('href', attr + '/nui/styles/styles.css');
}
