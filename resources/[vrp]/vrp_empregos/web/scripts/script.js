const app = {
  open: function () {
    document.querySelector('#app').style.display = 'block';
  },

  close: function () {
    fetch('http://vrp_empregos/closeNui', { method: 'POST' });
    document.querySelector('#app').style.display = 'none';
  },

  start: function (type) {
    fetch(`http://vrp_empregos/${type}`, { method: 'POST' });
    app.close();
  },

  buffed: function(route) {
    const routes = document.querySelectorAll('.route')
    if (route === 'south') {
      routes.forEach(r => r.classList.remove('selected'))
      routes[0].classList.add('selected')
      routes[0].querySelector('img#fire').style.display = 'block'
      routes[0].querySelector('img#buffed').style.display = 'block'
      routes[1].querySelector('img#buffed').style.display = 'none'
      routes[1].querySelector('img#fire').style.display = 'none'
    } else if (route === 'north') {
      routes.forEach(r => r.classList.remove('selected'))
      routes[1].classList.add('selected')
      routes[1].querySelector('img#fire').style.display = 'block'
      routes[1].querySelector('img#buffed').style.display = 'block'
      routes[0].querySelector('img#fire').style.display = 'none'
      routes[0].querySelector('img#buffed').style.display = 'none'
   } else if (route === 'double') {
      routes.forEach(r => r.classList.add('selected'))
      routes[1].querySelector('img#fire').style.display = 'block'
      routes[1].querySelector('img#buffed').style.display = 'block'
      routes[0].querySelector('img#fire').style.display = 'block'
      routes[0].querySelector('img#buffed').style.display = 'block'
    }  else {
      routes.forEach(r => r.classList.remove('selected'))
      routes[0].querySelector('img#fire').style.display = 'none'
      routes[0].querySelector('img#buffed').style.display = 'none'   
      routes[1].querySelector('img#fire').style.display = 'none'
      routes[1].querySelector('img#buffed').style.display = 'none'  
    }
  }
}

window.addEventListener('keyup', ({key}) => {
  if (key === 'Escape') app.close();
})

window.addEventListener('message', ({data}) => {
  if (data.showmenu) app.open(data);
  if (data.hidemenu) app.close();

  if (data.action === 'setRouteBuffed') app.buffed(data.route)
})