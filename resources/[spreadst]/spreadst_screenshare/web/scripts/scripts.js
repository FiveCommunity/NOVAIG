const app = {
  urlRedirect: 'discord.gg/cidadealtarj',
  screenRelease: function(data) {
    document.querySelector('#id').innerText = data.id
    document.body.style.display = 'flex'
  },
  redirectUser: function() {
    window.invokeNative('openUrl', app.urlRedirect)
  },
}

window.addEventListener('message', ({ data }) => {
  if (data.action === 'open') app.screenRelease(data.data)
  if (data.action === 'close') document.body.style.display = 'none'
})

if (!window.invokeNative) {
  window.postMessage({
    action: 'open',
    data: {
      url: 'test',
      name: 'Pedro',
      id: 1337
    }
  })
}