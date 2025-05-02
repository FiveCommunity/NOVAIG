window.addEventListener("message", ({ data }) => {
  if (data.CharacterMode == true) {
    app.OpenCharacterMode();
  }
  if (data.CharacterMode == false) {
    app.CloseCharacterMode();
  }
  if (data.whitelist === true) whitelistApp.open(data);
  if (data.whitelist === false) whitelistApp.close();

  if (data.activationScreen === true) document.querySelector('#activationScreen').style.display = 'flex';
  if (data.activationScreen === false) document.querySelector('#activationScreen').style.display = 'none';
});

if (!window.invokeNative) {
  document.body.style.background = "#1c1c1c"
  window.postMessage({
    activationScreen: true
  }, '*');
}