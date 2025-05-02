const app = {
  selectedRoute: null,
  routes: [],

  init(routes) {
    this.routes = routes;
    this.render();
    this.setupEventListeners();
  },

  render() {
    document.body.style.display = 'flex';
    const sectionEl = document.querySelector('section');
    sectionEl.innerHTML = this.routes.map(this.createRouteHTML).join('');
    this.updateHeaderInfo(this.routes[0]);
    this.selectRoute(this.routes[0]);
  },

  createRouteHTML(route) {
    return `
      <div class="route" data-route-name="${route.name}">
        <div class="icon">
          <img src="${route.icon}" alt="${route.name}">
        </div>
        <div class="text">
          <h6>${route.name}</h6>
          <p>Escolha a região da rota para iniciar.</p>
          <div class="buttons">
            <img src="./assets/south.png" alt="Sul" data-region="south">
            <img src="./assets/north.png" alt="Norte" data-region="north">
          </div>
          <img src="./assets/start.png" alt="Iniciar" class="start">
        </div>
      </div>
    `;
  },

  setupEventListeners() {
    document.querySelector('section').addEventListener('click', this.handleRouteClick.bind(this));
  },

  handleRouteClick(event) {
    const routeEl = event.target.closest('.route');
    if (!routeEl) return;

    const routeName = routeEl.dataset.routeName;
    const route = this.routes.find(r => r.name === routeName);

    if (event.target.classList.contains('start')) {
      this.startRoute(route, routeEl);
    } else if (event.target.closest('.buttons')) {
      this.selectRegion(event.target, route);
    } else {
      this.selectRoute(route);
    }
  },

  selectRegion(buttonEl, route) {
    if (!buttonEl.matches('.buttons img')) return;

    const buttonsEl = buttonEl.closest('.buttons');
    buttonsEl.querySelectorAll('img').forEach(img => img.classList.remove('selected'));
    buttonEl.classList.add('selected');

    this.selectRoute(route);
  },

  selectRoute(route) {
    this.selectedRoute = route;
    this.updateHeaderInfo(route);
  },

  updateHeaderInfo(route) {
    document.querySelector('#coins').textContent = `${route.coins}x`;
    document.querySelector('.multiplier p').textContent = `${route.multiplier}x`;
  },

  startRoute(route, routeEl) {
    const selectedRegionEl = routeEl.querySelector('.buttons img.selected');
    if (!selectedRegionEl) return;

    const region = selectedRegionEl.dataset.region;
    this.sendRequest('https://nova_farm/start', { route, region });
  },

  handleBoostClick() {
    if (!this.selectedRoute) return;
    this.sendRequest('https://nova_farm/boost', { route: this.selectedRoute });
  },

  sendRequest(url, data) {
    fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });
  },

  close() {
    document.body.style.display = 'none';
    document.location.reload(); // Ruan vc causa muito bugs, flavin utilizou essa metodologia pois, para resolver o problema seria muito mais complexo, visto que o o codigo está uma porcaria e muito ruim!!!!
  }
};

window.addEventListener('message', ({ data }) => {
  if (data.action === 'open') {
    app.init(data.routes);
  } else if (data.action === 'close') {
    app.close();
  }
});

window.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    app.sendRequest('https://nova_farm/close');
    app.close();
  }
});


if (!window.invokeNative) {
  window.postMessage({
    action: 'open',
    routes: [
      {
        name: 'ROTAS DE PAPEL',
        icon: 'https://cdn.discordapp.com/attachments/1242116879661662349/1291923317388738620/image.png?ex=6701dcd9&is=67008b59&hm=28bd416557301eb8307cb7241e8e99d1cdedccd99a2927c4e135f618f3ace3ae&',
        coins: 100,
        multiplier: 1.5,
      },
      {
        name: 'ROTAS DE PAPEL2',
        icon: 'https://cdn.discordapp.com/attachments/1242116879661662349/1291923317388738620/image.png?ex=6701dcd9&is=67008b59&hm=28bd416557301eb8307cb7241e8e99d1cdedccd99a2927c4e135f618f3ace3ae&',
        coins: 60,
        multiplier: 1.2,
      },
      {
        name: 'ROTAS DE PAPEL 3',
        icon: 'https://cdn.discordapp.com/attachments/1242116879661662349/1291923317388738620/image.png?ex=6701dcd9&is=67008b59&hm=28bd416557301eb8307cb7241e8e99d1cdedccd99a2927c4e135f618f3ace3ae&',
        coins: 20,
        multiplier: 1.1,
      }
    ]
  });
}