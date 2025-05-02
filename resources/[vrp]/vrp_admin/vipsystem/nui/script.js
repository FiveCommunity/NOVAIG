$(document).ready(() => {
    window.addEventListener('message', function ({data}) {
        if(data.action == 'vipsystem'){
            openVipSystem(data.link)
        }
    });
})

const openVipSystem = (link) => {
    window.invokeNative("openUrl", link || "https://hydrus.gg")
}