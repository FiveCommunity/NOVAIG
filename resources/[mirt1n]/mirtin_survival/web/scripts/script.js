const spawn = (name) => {
  fetch('http://mirtin_survival/spawn', {
    method: 'POST',
    body: JSON.stringify({ name })
  })
}

function formatTime(seconds) {
  const minutes = Math.floor(seconds / 60);
  const restSeconds = seconds % 60;
  const time = `${minutes.toString().padStart(2, '0')}:${restSeconds.toString().padStart(2, '0')}`;
  return time;
}

function callFireman() {
  fetch('http://mirtin_survival/callFireman', { method: 'POST' })
}

let called = false
function callStaff() {
  if (called) return
  setTimeout(() => called = false, 5000)
  fetch('http://mirtin_survival/callStaff', { method: 'POST' })
  called = true
}

const notify = ({ id, distance }) => {
  document.querySelector(".notify .info #id b").innerHTML = id
  document.querySelector(".notify .info #distance b").innerHTML = `${distance.toLocaleString('pt-BR')}m`
  document.querySelector(".notify").style.display = 'block'
}

window.addEventListener('keydown', (e) => {
  if (e.key === 'e') callFireman()
})

window.addEventListener("message", ({ data }) => {
  if (data.action === 'open') {
    document.querySelector("#death-message").innerHTML = `Morto por: <b>${data.killer}</b>`
    if (data.deathtimer > 0) {
      timer = data.deathtimer
      const percentage = Math.floor((data.deathtimer / (data.deathtimer === 300 ? data.deathtimer : 500)) * 100)
      document.querySelector(".call-fireman").style.display = 'flex'
      document.querySelector(".timer").style.display = 'flex'
      document.querySelector(".progress-container").style.display = 'flex'
      document.querySelector(".progress").style.width = `${percentage}%`
      document.querySelector(".time-left").style.display = 'flex'
      document.querySelector(".locales").style.display = 'none'
      document.querySelector(".timer").innerHTML = ` <p>${formatTime(data.deathtimer)}</p> `;
    } else {
      document.querySelector(".call-fireman").style.display = 'none'
      document.querySelector(".progress-container").style.display = 'none'
      document.querySelector(".time-left").style.display = 'none'
      document.querySelector(".progress").style.width = '0%'
      document.querySelector(".timer").style.display = 'none'
      document.querySelector(".locales").style.display = 'flex'
      document.querySelector(".timer").innerHTML = ` <p>00:00</p> `;
    }
    document.querySelector("#app").style.display = "flex";
  } else if (data.action === 'close') {
    document.querySelector("#app").style.display = "none";
  }

  if (data.action === "notify") notify(data)
  if (data.action === "notify:close") document.querySelector(".notify").style.display = 'none'
});

if (!window.invokeNative) {
  // window.postMessage({ action: "notify", distance: 22, id: 2 })
  // window.postMessage({ action: 'open', deathtimer: 20, killer: 'Pedro#30' })
}