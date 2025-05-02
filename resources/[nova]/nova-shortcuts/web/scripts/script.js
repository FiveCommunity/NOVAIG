const open = () => {
  document.body.style.display = 'flex';
}

const close = () => {
  document.body.style.display = 'none';
}

window.addEventListener('keyup', ({key}) => {
  if (key === 'Escape') {
    fetch('http://lotus-shortcuts/close', { method: 'POST' })
    close()
  }
})

window.addEventListener('message', ({data}) => {
  if (data.action === 'open') open()
  if (data.action === 'close') close()
})

if (!window.invokeNative) {
  window.postMessage({
    action: 'open'
  })
}
