"use client"

// Atualizar o relógio na barra de status
function updateClock() {
  const now = new Date()
  const hours = now.getHours().toString().padStart(2, "0")
  const minutes = now.getMinutes().toString().padStart(2, "0")
  document.querySelector(".time").textContent = `${hours}:${minutes}`
}

// Atualizar o relógio a cada minuto
setInterval(updateClock, 60000)
updateClock() // Inicializar o relógio

// Modal de confirmação personalizado
const modal = document.getElementById("confirmModal")
const confirmBtn = document.getElementById("confirmBtn")
const cancelBtn = document.getElementById("cancelBtn")

// Função para mostrar o modal
function showModal() {
  modal.style.display = "flex"
}

// Função para esconder o modal
function hideModal() {
  modal.style.display = "none"
}

// Fechar modal ao clicar no botão cancelar
cancelBtn.addEventListener("click", hideModal)

// Evento de mensagem da janela
window.addEventListener("message", (event) => {
  // Reset html items
  $("#grupos").empty()
  $("#escolhas").empty()
  document.getElementById("playerId").value = ""

  var item = event.data
  if (item.conce == true) {
    criarLista(item.data)
    $("body").css("display", "flex")
    $(".tablet-container").css("display", "flex")
    $("#player-id-display").text(item.id ?? "??")
  } else if (item.conce == false) {
    $("body").css("display", "none")
    $(".tablet-container").css("display", "none")
  }
})

function criarLista(data) {
  document.getElementById("playerId").value = data[2].toString()
  $("#player-id-display").text(data[2].toString())

  data[1].forEach((item, key) => {
    const div = `<div class='grupo' onClick='javasript:atribuir("${key}${item}")' id='${key}${item}' data-value='${item}'>${item}</div>`
    $("#grupos").append(div)
  })

  data[0].forEach((item, key) => {
    const div = `<div class='player' onClick='javasript:atribuir("${key}${item}")' id='${key}${item}' data-value='${item}'>${item}</div>`
    $("#escolhas").append(div)
  })
}

function filterGroups() {
  const query = document.getElementById("groupSearch").value.toLowerCase()
  const grupos = document.querySelectorAll("#grupos .grupo")

  grupos.forEach((grupo) => {
    const groupName = grupo.getAttribute("data-value").toLowerCase()
    if (groupName.includes(query)) {
      grupo.style.display = ""
    } else {
      grupo.style.display = "none"
    }
  })
}

function atribuir(id) {
  const item = document.getElementById(id)
  if (item.className == "grupo") {
    item.classList.add("player")
    item.classList.remove("grupo")
    $("#escolhas").append(item)
  } else {
    item.classList.add("grupo")
    item.classList.remove("player")
    $("#grupos").append(item)
  }
}

// Botão salvar com confirmação
$(".save-button").click(() => {
  showModal()
})

// Confirmar alterações
confirmBtn.addEventListener("click", () => {
  const valores = []
  const grupos = $(".player")
  grupos.get().forEach((item) => {
    valores.push($(item).data("value"))
  })

  const player = document.getElementById("playerId").value

  $.post("http://five_setgroup/aceitar", JSON.stringify({ valores, player }))

  hideModal()
  setTimeout(() => {
    $("body").css("display", "none")
  }, 500)
})

$("#close").click(() => {
  $("body").css("display", "none")
  $.post("http://five_setgroup/close", JSON.stringify({}))
})

$(document).keydown((e) => {
  if (e.keyCode == 27) {
    $("body").css("display", "none")
    $.post("http://five_setgroup/close", JSON.stringify({}))
    hideModal()
  }
})

// Adicionar efeito de ondulação (ripple) aos botões
function createRipple(event) {
  const button = event.currentTarget

  const circle = document.createElement("span")
  const diameter = Math.max(button.clientWidth, button.clientHeight)

  circle.style.width = circle.style.height = `${diameter}px`
  circle.style.left = `${event.clientX - button.getBoundingClientRect().left - diameter / 2}px`
  circle.style.top = `${event.clientY - button.getBoundingClientRect().top - diameter / 2}px`
  circle.classList.add("ripple")

  const ripple = button.querySelector(".ripple")
  if (ripple) {
    ripple.remove()
  }

  button.appendChild(circle)
}

const buttons = document.querySelectorAll(".action-button, .modal-btn")
buttons.forEach((button) => {
  button.addEventListener("click", createRipple)
})

// Adicionar classe ripple ao CSS
const style = document.createElement("style")
style.textContent = `
.action-button, .modal-btn {
    position: relative;
    overflow: hidden;
}
.ripple {
    position: absolute;
    background: rgba(255, 255, 255, 0.3);
    border-radius: 50%;
    transform: scale(0);
    animation: ripple 0.6s linear;
    pointer-events: none;
}
@keyframes ripple {
    to {
        transform: scale(4);
        opacity: 0;
    }
}
`
document.head.appendChild(style)

// Ensure jQuery is loaded
if (typeof jQuery == "undefined") {
  console.error("jQuery is not loaded. Please ensure jQuery is included in your HTML.")
} else {
  // Now you can use jQuery safely
  $(document).ready(() => {
    // Botão salvar com confirmação
    $(".save-button")
      .off("click")
      .click(() => {
        showModal()
      })

    // Confirmar alterações
    confirmBtn.removeEventListener("click", () => {}) // Remove any existing event listener
    confirmBtn.addEventListener("click", () => {
      const valores = []
      const grupos = $(".player")
      grupos.get().forEach((item) => {
        valores.push($(item).data("value"))
      })

      const player = document.getElementById("playerId").value

      $.post("http://five_setgroup/aceitar", JSON.stringify({ valores, player }))

      hideModal()
      setTimeout(() => {
        $("body").css("display", "none")
      }, 500)
    })

    $("#close")
      .off("click")
      .click(() => {
        $("body").css("display", "none")
        $.post("http://five_setgroup/close", JSON.stringify({}))
      })

    $(document)
      .off("keydown")
      .keydown((e) => {
        if (e.keyCode == 27) {
          $("body").css("display", "none")
          $.post("http://five_setgroup/close", JSON.stringify({}))
          hideModal()
        }
      })
  })
}

