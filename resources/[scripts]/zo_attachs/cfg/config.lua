config = {
  salvarAttachsDb = true, -- SALVAR OS ATTACHS APLICADOS NO BANCO DE DADOS
  perderAttachsAoMorrer = false,
}

blips = {
  { x = 18.5, y = -1109.86, z = 29.8, perms = { }, pagarPelaModificacao = true, usarItens = false }
}

comandos = {
  { comando = "attachs2", perms = { "developer.permissao", "perm.respilegal", "perm.resppolicia", "perm.attachs2" } },
  -- { comando = "ati", perms = { }, pagarPelaModificacao = true, usarItens = true },
  -- { comando = "ats", perms = { }, pagarPelaModificacao = true, usarItens = false }
}

priceAttachs = {
  mira = 1000,
  cano = 2000,
  grip = 3000,
  lanterna = 4000,
  carregador = 10000,
  municao = 8000,
  textura = 5000,
  textura_slide = 5000,
  cor = 1000,
}

attachsDefault = {
  ["mira"] = { text = "MIRA", price = 1000, imgCategoria = "https://imgur.com/ilpm03u.png" },
  ["cano"] = { text = "CANO", price = 2000, imgCategoria = "https://imgur.com/tM06Mum.png" },
  ["grip"] = { text = "GRIP", price = 3000, imgCategoria = "https://imgur.com/vbRBfZK.png" },
  ["lanterna"] = { text = "LANTERNA", price = 4000, imgCategoria = "https://imgur.com/HWKYHIk.png" },
  ["carregador"] = { text = "CARREGADOR", price = 5000, imgCategoria = "https://imgur.com/LRE7qiJ.png" },
  ["municao"] = { text = "MUNIÇÃO", price = 6000, imgCategoria = "https://imgur.com/dfamhES.png" },
  ["cor"] = { text = "COR DA ARMA", price = 1000, imgCategoria = "https://imgur.com/dTVpWsH.png" },
  ["textura"] = { text = "TEXTURA DA ARMA", price = 3500, imgCategoria = "https://imgur.com/9zpIjgv.png" },
  ["textura_slide"] = { text = "TEXTURA DO SLIDE", price = 2000, imgCategoria = "https://imgur.com/9zpIjgv.png" },
}

attachsItens = {
  mira = "attmira",
  cano = "attcano",
  grip = "attgrip",
  lanterna = "attlanterna",
  carregador = "attcarregador",
  textura = "atttextura",
  textura_slide = "atttexturaslide",
  cor = "attlatatinta",
}