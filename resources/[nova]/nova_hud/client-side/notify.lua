local AnnouceTypes = {
  ['police'] = {
    icon = './icons/police.png',
    title = 'AVISO POLICIAL'
  },
  ['hospital'] = {
    icon = './icons/hospital.png',
    title = 'AVISO HOSPITAL'
  },
  ['kids'] = {
    icon = './icons/kids.png',
    title = 'AVISO CRECHE'
  },
  ['party'] = {
    icon = './icons/party.png',
    title = 'AVISO FESTA'
  },
  ['fireman'] = {
    icon = './icons/fireman.png',
    title = 'AVISO BOMBEIROS'
  },
  ['judiciary'] = {
    icon = './icons/judiciary.png',
    title = 'AVISO JUDICIARIO'
  },
  ['vip'] = {
    icon = './icons/vip.png',
    title = 'AVISO VIP'
  },
  ['mechanic'] = {
    icon = './icons/mechanic.png',
    title = 'AVISO MECANICO'
  },
  ['relacionamento'] = {
    icon = './icons/relacionamento.png',
    title = 'RELACIONAMENTO'
  },
  ['avisostaff'] = {
    icon = './icons/staff.png',
    title = 'AVISO STAFF'
  },
  ['juridico'] = {
    icon = './icons/juridico.png',
    title = 'JURÍDICO'
  },
}


RegisterNetEvent('Announcement', function(type, message, time, title)

  if not AnnouceTypes[type] then return end

  SendNUIMessage({
    action = 'Announcement',
    data = {
      title = title or (AnnouceTypes[type] and AnnouceTypes[type].title or title),
      type = type,
      icon = (AnnouceTypes[type] and AnnouceTypes[type].icon or './icons/party.png'),
      message = message,
      time = time * 1000,
    }
  })
end)