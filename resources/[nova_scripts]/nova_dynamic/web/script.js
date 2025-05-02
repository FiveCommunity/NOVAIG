const app = {
  open: ({ targets, status, type }) => {
    const list = document.querySelector('.list');
    const action = document.querySelector('.status');
    document.body.style.display = 'block';

    list.innerHTML = '';
    app.updateStatus(action, status);
    app.renderTargets(targets, type);
  },

  renderTargets: (targets, type) => {
    const list = document.querySelector('.list');
    targets.forEach(target => {
      const div = app.createTargetElement(target);
      div.addEventListener('click', () => app.handleTargetClick(target, type));
      list.appendChild(div);
    });
  },

  createTargetElement: (target) => {
    const div = document.createElement('div');
    div.classList.add('target');
    if (!target.image) {
      div.classList.add('no-image');
    }

    const imageHtml = target.image ? `<img src="${target.image}" alt="${target.name}">` : '';
    const trashHtml = target.delete ? '<img class="trash" src="./assets/trash.svg" alt="trash">' : '';

    div.innerHTML = `
      ${imageHtml}
      <p>${target.name}</p>
      ${trashHtml}
    `;

    if (target.delete) {
      const trashIcon = div.querySelector('.trash');
      trashIcon.addEventListener('click', (event) => {
        event.stopPropagation();
        app.sendRequest('deleteOutfit', { target, type: 'delete' });
      });
    }

    return div;
  },

  handleTargetClick: (target, type) => {
    if (target.modal) {
      app.showModal(target, type);
    } else  {
      app.sendRequest('target', { target, type });
    }
  },

  showModal: (target, type) => {
    const modal = document.querySelector('.modal');
    const input = modal.querySelector('.input input');
    const saveButton = document.querySelector('#save');
    const closeButton = document.querySelector('#close');

    modal.style.display = 'flex';
    input.focus();

    const saveHandler = () => {
      app.sendRequest('saveOutfit', { target, type, name: input.value });
      app.closeModal(modal, input, saveHandler, closeHandler);
    };

    const closeHandler = () => {
      app.closeModal(modal, input, saveHandler, closeHandler);
    };

    saveButton.addEventListener('click', saveHandler);
    closeButton.addEventListener('click', closeHandler);
  },

  closeModal: (modal, input, saveHandler, closeHandler) => {
    modal.style.display = 'none';
    input.value = '';
    document.querySelector('#save').removeEventListener('click', saveHandler);
    document.querySelector('#close').removeEventListener('click', closeHandler);
  },

  sendRequest: (endpoint, data) => {
    fetch(`https://nova_dynamic/${endpoint}`, {
      method: 'POST',
      body: JSON.stringify(data)
    });
  },

  updateStatus: (actionElement, status) => {
    const statusMap = {
      home: 'close',
      close: 'close',
      back: 'back'
    };

    const newStatus = statusMap[status] || status;
    actionElement.src = `./assets/${newStatus}.svg?v=${Date.now()}`;
    actionElement.setAttribute('status', newStatus);
  },

  goBack: (element) => {
    const attribute = element.getAttribute('status');
    if (attribute === 'close') {
      app.close();
      app.sendRequest('close', {});
    } else if (attribute === 'back') {
      app.sendRequest('back', {});
    }
  },

  close: () => {
    document.body.style.display = 'none';
    document.querySelector('.list').innerHTML = '';
  }
};

window.addEventListener('message', ({ data }) => {
  if (data.action === 'open') {
    app.open(data);
  } else if (data.action === 'close') {
    app.close();
  } else if (data.action === 'updateStatus') {
    const action = document.querySelector('.status');
    app.updateStatus(action, data.status);
  }
});

window.addEventListener('keydown', ({ keyCode }) => {
  if (keyCode === 27) {
    app.sendRequest('close', {});
    app.close();
  }
});

if (!window.invokeNative) {
  window.postMessage({
    action: 'open',
    targets: [
      { name: 'Porta malas', image: './assets/vehicle.svg', delete: true },
      { name: 'Porta malas', image: './assets/vehicle.svg', delete: false },
      { name: 'Porta malas', image: './assets/vehicle.svg', delete: true, modal: true }
    ],
    status: 'back'
  });
}