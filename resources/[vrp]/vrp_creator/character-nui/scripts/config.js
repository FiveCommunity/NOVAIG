// const containerVehicles = document.querySelector('.vehicles')
//   containerVehicles.innerHTML = config.vehicles.map((vehicle) => `
//       <div class = "vehicle" data-spawn="${vehicle.spawn}" onclick="whitelistApp.selectVehicle(this)" style="cursor: pointer;">
//         <div class = 'text'>
//             <h4>${vehicle.name}</h4>
//             <p>${vehicle.type}</p>
//         </div>
//         <img src="${vehicle.image}" alt="">
//       </div>
//   `).join(" ")

const post = async (url, data = {}, mock) => {
  const resourceName = window.GetParentResourceName ? GetParentResourceName() : 'vrp_creator';
  if (mock && !window.invokeNative) {
    return mock;
  }
  return fetch(`https://${resourceName}/${url}`, { method: 'POST', body: JSON.stringify(data) })
    .then(res => res.json());
};

const whitelistApp = {
  id: 120,
  currentPage: 1,

  open: ({ id }) => {
    document.querySelector('#whitelist').style.display = "flex";
    document.querySelector('#passport').innerHTML = id;
    whitelistApp.id = id;
  },
  step: () => {
    if (whitelistApp.currentPage === 1) {
      const name = document.getElementById('name').value;
      const surname = document.getElementById('surname').value;
      const age = document.querySelector('article #age').value;

      const regexName = /^[a-zA-Z]+$/;
      if (!regexName.test(name) || !regexName.test(surname)) {
        notify.create('Você não pode colocar nomes com caracteres especiais');
        return;
      }

      if (name.length < 3 || surname.length < 3) {
        notify.create('Você não pode colocar nomes com menos de 3 caracteres');
        return;
      }

      if (name.length > 25 || surname.length > 25) {
        notify.create('Você não pode colocar nomes com mais de 25 caracteres');
        return;
      }

      if (!name.trim() || !surname.trim() || age < 18 || age > 99 || !find) {
        notify.create('Campos incorreto, preencha todos! Verifique se a idade está entre 18 e 99 e se os nomes não possuem espaços.');
        return;
      }

      document.querySelectorAll('#whitelist section')[0].style.display = 'none';
      document.querySelectorAll('#whitelist section')[1].style.display = 'flex';
      document.querySelectorAll('#whitelist .steps .step')[1].style.background = '#840D0D';
      document.querySelectorAll('#whitelist .steps .step')[1].style.color = '#fff';
      document.querySelectorAll('#whitelist .line')[0].style.background = '#840D0D';
      document.querySelectorAll('#whitelist .line')[1].style.background = 'linear-gradient(90deg, #840D0D 0%, rgba(211, 19, 47, 0.00) 100%)';
      document.querySelector('#whitelist main img.title').src = './assets/icons/joinDiscord.svg';
      whitelistApp.currentPage = 2;
      return;
    }

    if (whitelistApp.currentPage === 2) {
      post('verify', {}, { whitelisted: true }).then((res) => {
        if (res.whitelisted) {
          document.querySelectorAll('#whitelist section')[1].style.display = 'none';
          document.querySelectorAll('#whitelist section')[2].style.display = 'flex';
          document.querySelector('#whitelist button').innerHTML = 'FINALIZAR';
          document.querySelector('#whitelist main img.title').src = './assets/icons/reward.svg';
          document.querySelectorAll('#whitelist .line')[1].style.background = '#840D0D';
          document.querySelectorAll('#whitelist .steps .step')[2].style.background = '#840D0D';
          document.querySelectorAll('#whitelist .steps .step')[2].style.color = '#fff';
          whitelistApp.currentPage = 3;
        }
      });
    }

    if (whitelistApp.currentPage === 3) {
      whitelistApp.post('finishWhitelist', {
        vehicle: document.querySelector("#whitelist article .vehicle.selected").dataset.spawn,
        name: document.querySelector('#whitelist #name').value,
        surname: document.querySelector('#whitelist #surname').value,
        age: Number(document.querySelector('#whitelist #age').value),
      });
      document.querySelector('#whitelist').style.display = 'none';
    }
  },
  close: () => {
    document.querySelector('#whitelist').style.display = 'none';
  },
  post: (url, data = {}, mock) => {
    const resourceName = window.GetParentResourceName ? GetParentResourceName() : 'vrp_creator';
    if (mock && !window.invokeNative) {
      return mock;
    }
    return fetch(`https://${resourceName}/${url}`, { method: 'POST', body: JSON.stringify(data) })
      .then(res => res.json());
  },
  copyId: () => {
    const copyFrom = document.createElement('textarea');
    copyFrom.innerHTML = whitelistApp.id;
    document.body.append(copyFrom);
    copyFrom.select();
    document.execCommand('copy');
    copyFrom.remove();

    notify.create('ID copiado para o seu CTRL+V');
  },
  redirect: () => {
    console.log(config.discordURL);
    window.invokeNative("openUrl", config.discordURL);
  },
  changeGender: (element, sex) => {
    document.querySelectorAll('#whitelist .buttons .gender').forEach((b) => b.classList.remove('selected'));
    element.classList.add('selected');
    whitelistApp.post("changeGender", { sex });
  },
  selectVehicle: (element) => {
    document.querySelector("#whitelist .vehicle.selected")?.classList.remove("selected");
    element.classList.add("selected");
  },
  confirm: () => {
    const name = document.querySelectorAll('#whitelist .fields input')[0].value;
    const surname = document.querySelectorAll('#whitelist .fields input')[1].value;
    const age = Number(document.querySelectorAll('#whitelist .fields input')[2].value);
    const find = document.querySelector('#whitelist select').value;
    if (whitelistApp.currentPage === 0) {
      const regexName = /^[a-zA-Z]+$/;
      if (!regexName.test(name) || !regexName.test(surname)) {
        notify.create('Você não pode colocar nomes com caracteres especiais');
        return;
      }
      if (!name.trim() || !surname.trim() || age < 18 || age > 99 || !find) {
        notify.create('Campos incorreto, preencha todos! Verifique se a idade está entre 18 e 99 e se os nomes não possuem espaços.');
        return;
      }
      document.querySelector('#whitelist .one .block_step').style.display = 'flex';
      document.querySelector('#whitelist .two .block_step').style.display = 'none';
      whitelistApp.currentPage = 1;
      return;
    }

    if (whitelistApp.currentPage === 1) {
      post("verify", {}, { whitelisted: true }).then((res) => {
        console.log(res);
        if (res.whitelisted) {
          document.querySelector('#whitelist .two .block_step').style.display = 'flex';
          document.querySelector('#whitelist .three .block_step').style.display = 'none';
          whitelistApp.currentPage = 2;
        }
      });
      return;
    }

    whitelistApp.post("finishWhitelist", {
      vehicle: document.querySelector("#whitelist .vehicles .vehicle.selected").dataset.spawn,
      name: document.querySelectorAll('#whitelist .fields input')[0].value,
      surname: document.querySelectorAll('#whitelist .fields input')[1].value,
      age: Number(document.querySelectorAll('#whitelist .fields input')[2].value),
      recommendation: Number(document.querySelector('#recommendation').value)
    });

    document.querySelector('#whitelist .one .block_step').style.display = 'none';
    document.querySelector('#whitelist .two .block_step').style.display = 'flex';
    document.querySelector('#whitelist .three .block_step').style.display = 'flex';
  }
};

const notify = {
  create: (text) => {
    const element = document.createElement("div")
    element.classList.add("notify")
    element.innerHTML = `
      <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M7.99334 2.66667C7.86227 2.78526 7.72455 2.89627 7.58084 2.99917C7.3325 3.16583 7.05334 3.28083 6.76 3.33917C6.6325 3.36417 6.49917 3.375 6.23334 3.39583C5.56584 3.44917 5.23167 3.47583 4.95334 3.57417C4.63508 3.68653 4.34603 3.86872 4.10738 4.10738C3.86873 4.34603 3.68653 4.63508 3.57417 4.95333C3.47584 5.23167 3.44917 5.56583 3.39584 6.23334C3.38675 6.40981 3.36783 6.58564 3.33917 6.76C3.28084 7.05334 3.16584 7.3325 2.99917 7.58083C2.92667 7.68917 2.84 7.79083 2.66667 7.99333C2.2325 8.50333 2.015 8.75833 1.8875 9.025C1.59334 9.64167 1.59334 10.3583 1.8875 10.975C2.015 11.2417 2.2325 11.4967 2.66667 12.0067C2.84 12.2092 2.92667 12.3108 2.99917 12.4192C3.16584 12.6675 3.28084 12.9467 3.33917 13.24C3.36417 13.3675 3.375 13.5008 3.39584 13.7667C3.44917 14.4342 3.47584 14.7683 3.57417 15.0467C3.68653 15.3649 3.86873 15.654 4.10738 15.8926C4.34603 16.1313 4.63508 16.3135 4.95334 16.4258C5.23167 16.5242 5.56584 16.5508 6.23334 16.6042C6.49917 16.625 6.6325 16.6358 6.76 16.6608C7.05334 16.7192 7.3325 16.835 7.58084 17.0008C7.68917 17.0733 7.79084 17.16 7.99334 17.3333C8.50334 17.7675 8.75834 17.985 9.025 18.1125C9.64167 18.4067 10.3583 18.4067 10.975 18.1125C11.2417 17.985 11.4967 17.7675 12.0067 17.3333C12.2092 17.16 12.3108 17.0733 12.4192 17.0008C12.6675 16.8342 12.9467 16.7192 13.24 16.6608C13.3675 16.6358 13.5008 16.625 13.7667 16.6042C14.4342 16.5508 14.7683 16.5242 15.0467 16.4258C15.3649 16.3135 15.654 16.1313 15.8926 15.8926C16.1313 15.654 16.3135 15.3649 16.4258 15.0467C16.5242 14.7683 16.5508 14.4342 16.6042 13.7667C16.625 13.5008 16.6358 13.3675 16.6608 13.24C16.7192 12.9467 16.835 12.6675 17.0008 12.4192C17.0733 12.3108 17.16 12.2092 17.3333 12.0067C17.7675 11.4967 17.985 11.2417 18.1125 10.975C18.4067 10.3583 18.4067 9.64167 18.1125 9.025C17.985 8.75833 17.7675 8.50333 17.3333 7.99333C17.2147 7.86227 17.1037 7.72455 17.0008 7.58083C16.8343 7.33241 16.7188 7.05341 16.6608 6.76C16.6322 6.58563 16.6133 6.40981 16.6042 6.23334C16.5508 5.56583 16.5242 5.23167 16.4258 4.95333C16.3135 4.63508 16.1313 4.34603 15.8926 4.10738C15.654 3.86872 15.3649 3.68653 15.0467 3.57417C14.7683 3.47583 14.4342 3.44917 13.7667 3.39583C13.5902 3.38674 13.4144 3.36783 13.24 3.33917C12.9466 3.28124 12.6676 3.16568 12.4192 2.99917C12.2756 2.89605 12.1379 2.78505 12.0067 2.66667C11.4967 2.2325 11.2417 2.015 10.975 1.8875C10.6706 1.74199 10.3374 1.66646 10 1.66646C9.66258 1.66646 9.32944 1.74199 9.025 1.8875C8.75834 2.015 8.50334 2.2325 7.99334 2.66667ZM13.6442 8.21917C13.7619 8.09026 13.8255 7.9209 13.8215 7.74633C13.8176 7.57176 13.7465 7.40544 13.623 7.28197C13.4996 7.1585 13.3332 7.08739 13.1587 7.08346C12.9841 7.07952 12.8147 7.14306 12.6858 7.26084L8.64417 11.3025L7.31417 9.97333C7.18526 9.85556 7.0159 9.79202 6.84133 9.79596C6.66676 9.7999 6.50044 9.871 6.37697 9.99447C6.2535 10.1179 6.1824 10.2843 6.17846 10.4588C6.17452 10.6334 6.23806 10.8028 6.35584 10.9317L8.16417 12.74C8.29134 12.8669 8.46367 12.9382 8.64334 12.9382C8.823 12.9382 8.99533 12.8669 9.1225 12.74L13.6442 8.21917Z" fill="#840D0D"/>
      </svg>

      <div>
        <p>${text}</p>
      </div>
    `;
    document.querySelector('.notify_list').appendChild(element);
    notify.delete(element);
  },
  delete: (element) => {
    setTimeout(() => {
      element.remove()
    }, 6000);
  }
}

const resetChar = () => {
  fetch('https://vrp_creator/resetChar', { method: 'POST' })
}

/* if (!window.invokeNative) {
  document.body.style.background = '#1c1c1c'
  whitelistApp.open({ id: 1 })
} */