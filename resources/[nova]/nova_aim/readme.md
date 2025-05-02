# Aim

O script já vem startado na tela de crosshair, para abrir a tela de configuração, é necessario enviar um sendnuimessage:

```lua
SendNUIMessage({
  action = 'opened',
  data = true
}) -- renderiza o script
```

Para alterar entre as paginas de configuração e de apenas mira:

```lua
SendNUIMessage({
  action = 'open:crosshair',
  data = true
}) -- vai para a pagina da mira
```

```lua
SendNUIMessage({
  action = 'open:configuration',
  data = true
}) -- vai para a pagina de configuração/criação da mira
```

Quando essa pagina é aberta, dispara um callback q carrega todas as miras do player:

```lua
RegisterNUICallback('GetAims', function(data, cb)
  -- De começo o player não vai ter nenhuma mira então caso não exista envie uma configuração default que seria a que está no callback: 
  cb({
    {
      name: "Default",
      color: "white",
      dot: { actived: true, thickness: 5, opacity: 1 },
      inner: { actived: false, opacity: 1, length: 6, thickness: 5, offset: 1 },
      outer: { actived: false, opacity: 1, length: 6, thickness: 5, offset: 10 },
    },
  })
end)
```

Para criar a mira é disparado um fetch para você que espera como callback true para fazer as alterações no front-end:

```lua
RegisterNUICallback('Create', function(data, cb)
  local config = data.config -- sempre que cria uma mira é preciso que voce armazene na db uma mira default as configurações são enviadas em base64 para você armazenar só o código.
  cb(true)
end)
```

Para copiar o codigo da sua propria mira é disparado um fetch e enviado o codigo em base64 dela, lembrando q vai ser necessario fechar a tela e abrir o prompt do jogo e colar a mira que eu envio em config:

```lua
RegisterNUICallback('Copy', function(data, cb)
  local config = data.config -- codigo da mira
  cb(true)
end)
```

## Utils

Código mira default: `eyJuYW1lIjoidGVzdDEiLCJjb2xvciI6IiNmZmZmZmYiLCJkb3QiOnsiYWN0aXZlZCI6ZmFsc2UsInRoaWNrbmVzcyI6NSwib3BhY2l0eSI6MH0sImlubmVyIjp7ImFjdGl2ZWQiOnRydWUsIm9wYWNpdHkiOjEsImxlbmd0aCI6NSwidGhpY2tuZXNzIjoyLCJvZmZzZXQiOjB9LCJvdXRlciI6eyJhY3RpdmVkIjpmYWxzZSwib3BhY2l0eSI6MSwibGVuZ3RoIjo2LCJ0aGlja25lc3MiOjUsIm9mZnNldCI6MTB9fQ`