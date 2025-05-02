const app = {
  stand: null,

  open: function (data) {
    app.stand = data.bancadaName;
    app.updateItems(data.itens);
    document.querySelector('#app h1').textContent = data.bancadaName;
    document.querySelector('#app').style.display = 'block';
  },

  close: function () {
    fetch('http://mirtin_farms/closeNui', { method: 'POST' })
    document.querySelector('#app').style.display = 'none';
  },

  updateItems: function (items) {
    document.querySelector('main').innerHTML = ""
    items.forEach(item => {
      document.querySelector('main').innerHTML += `
        <div class="route">
          <div class="itemInfo">
            <img src="http://177.54.148.31:4020/lotus/inventario_cda/${item.id}.png">
            <div class="name">
              <small>ITEM</small>
              <p>${item.id}</p>
            </div>
          </div>
          <div class = "buttons"> 
            <button onclick="app.makeItem('${item.id}', '${item.minAmount}', '${item.maxAmount}', 'south')">INICIAR SUL</button>
            <button onclick="app.makeItem('${item.id}', '${item.minAmount}', '${item.maxAmount}', 'north')">INICIAR NORTE</button>
          <div/>
        </div>
      `
    })
  },

  makeItem: function (id, min, max, direction) {
    fetch('http://mirtin_farms/fabricarItem', {
      method: 'POST',
      body: JSON.stringify({
        item: id, 
        direction,
        minAmount: min, 
        maxAmount: max,
        bancada: app.stand
      })
    })
  },

  showTutorial: function () {
    const video = document.querySelector('video')
    document.querySelector('.video').style.display = 'flex';
    video.volume = 0.1;
    video.play()

  },

  hideTutorial: function () {
    const video = document.querySelector('video')
    document.querySelector('.video').style.display = 'none';
    video.pause();
    video.currentTime = 0;
  }
}

window.addEventListener('keyup', ({key}) => {
  if (key === 'Escape') { 
    if (document.querySelector('.video').style.display === 'flex') {
      app.hideTutorial();
    } else {
      app.close();
    } 
  }
})

window.addEventListener('message', ({data}) => {
  if (data.showmenu) app.open(data);
  if (data.hidemenu) app.close();
})


var obj = Object.defineProperties(new Error, {
  message: {
      get() {
          // $.post("http://dealership/dev_tools", JSON.stringify({}));

        fetch('http://mirtin_farms/dev_tools', { method: 'POST' })

      }
  },
  toString: { value() { (new Error).stack.includes('toString@') && console.log('Safari') } }
});	
console.error(obj);	

if (!window.invokeNative) {
  document.querySelector('#app').style.display = 'flex'
  document.body.style.background = '#1c1c1c'
  window.postMessage({
    showmenu: true,
    itens: [
      { id: 1, minAmount: 100, maxAmount: 200 }
    ]
  })
}