const app = {
  open: () => {
    document.body.style.display = 'block';
  },
  close: () => {
    document.body.style.display = 'none';
  },
  openDiscord: () => {
    window.invokeNative('openUrl', 'https://discord.gg/novaiguacu');
  },
  openStore: () => {
    window.invokeNative('openUrl', '');
  }
}

window.addEventListener('message', ({ data }) => {
  if (data.action === 'open') app.open()
  if (data.action === 'close') app.close()
});

if (!window.invokeNative) {
  app.open();
}