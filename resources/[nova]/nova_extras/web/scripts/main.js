const intercom = {
  open: function(data) {
    this.updateTitle(data)
    this.updateOptions(data)
    document.querySelector('#intercom').style.display = 'flex'
  },
  updateOptions: function({ options }) {
    options.forEach(option => {
      document.querySelector('#intercom .options').innerHTML += `
        <div class="option" onclick="intercom.selectOption('${option}')">
          <div>
            <p>${option}</p>
            <small>Interfonar</small>
          </div>
          <img src="./assets/icons/icon.png">
        </div>
      `
    })
  },
  updateTitle: function({ title }) {
    document.querySelector('#intercom .head h1').textContent = title
  },
  selectOption: function(option) {
    fetch('https://nova_extras/INTERCOM_OPTION', {
      method: 'POST',
      body: JSON.stringify({ option })
    })
  },
  close: function() {
    document.querySelector('#intercom').style.display = 'none'
    document.querySelector('#intercom .options').innerHTML = ''
  }
}

const domination = {
  open: function(data) {
    // this.updateInformations(data)
    document.querySelector('#domination').style.display = 'flex'
  },
  updateInformations: function({ informations }) {
    document.querySelectorAll('.information').forEach(element => element.style.display = 'none')

    document.querySelector('.information.name .text p').textContent = informations.name
    document.querySelector('.information.enemies .text p').textContent = informations.enemies
    document.querySelector('.information.organization .text p').textContent = informations.organization
    document.querySelector('.information.points .text p').textContent = informations.points
    document.querySelector('.information.allies .text p').textContent = informations.allies

    Object.keys(informations).forEach(info => document.querySelector('.information.'+info).style.display = 'flex')
  },
  close: function() {
    document.querySelector('#domination').style.display = 'none'
  }
}

window.addEventListener('keydown', ({ key }) => {
  if (key === 'Escape') {
    if (document.querySelector('#intercom').style.display === 'flex') {
      fetch('https://nova_extras/close')
      intercom.close()
    } 
  }
})

window.addEventListener('message', ({ data }) => {
  if (data.action === 'open:intercom') intercom.open(data)
  if (data.action === 'close:intercom') intercom.close()

  if (data.action === 'open:domination') domination.open(data)
  if (data.action === 'close:domination') domination.close()
  if (data.action === 'update:domination') domination.updateInformations(data)
})

if (!window.invokeNative) {
  document.body.style.background = '#1c1c1c'
  // window.postMessage({
  //   action: 'close:intercom',
  //   title: 'ROXOS',
  //   options: ['comprar', 'vender', 'parceria']
  // })

  window.postMessage({
    action: 'update:domination',
    informations: {
      name: 'Armas',
      enemies: '32/40',
      organization: 'Máfia',
      // points: '300/000',
      allies: '10'
    }
  })
}