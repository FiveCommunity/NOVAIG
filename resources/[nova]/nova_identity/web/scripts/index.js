
/* 
action = "open",
image = avatarURL,
id = user_id,
name = identity.nome .. " " .. identity.sobrenome,
rg = identity.registro,
birth = identity.idade,
telephone = identity.telefone,
org = org,
spouse = spouse, 
wallet = vRP.getMoney(user_id),
bank = vRP.getBankMoney(user_id),

carry = porte,
staff = isStaff,
vips = currentVips,
*/

window.addEventListener('message', ({ data }) => {
  if (data.action === 'close') {
    document.body.style.display = 'none'
  } else if (data.action === 'open') {
    document.querySelector('.vips').innerHTML = ''

    document.querySelector('#icon').src = data.image ?? './assets/logo.png'
    document.querySelector('#name').innerHTML = `${data.name}<b> #${data.id}</b>`
    document.querySelector('#rg').innerText = data.id
    document.querySelector('#age').innerText = data.birth
    document.querySelector('#telephone').innerText = data.telephone
    document.querySelector('#org').innerText = data.org
    document.querySelector('#status').innerText = data.status_spouse
    document.querySelector('#spouse').innerText = data.spouse
    document.querySelector('#wallet').innerText = data.wallet
    document.querySelector('#bank').innerText = data.bank
    document.querySelector('#carry').innerText = data.carry ?? 'Não possui'

    data.vips?.forEach((vip) => {
      document.querySelector('.vips').innerHTML += `
        <div class="vip">
          <div class="title">
            <img src="./assets/crown.svg">
            <p>VIP</p>
          </div>
          <p>${vip}</p>
        </div>
      `;
    })

    document.body.style.display = 'flex'
  }
})

if (!window.invokeNative) {
  document.body.style.display = 'flex'
  document.body.style.background = '#1c1c1c'
}