module.exports = {
  // Se você quiser configurar uma permissão para cada modo, utilize o formato abaixo:
  // permission: { radio: 'permissao.jbl', bluetooth: 'permissao.bluetooth' },

  permission: 'perm.user',

  command: 'som',
  prop: 'rojo_jblboombox',
  
  // Distância máxima (em metros) entre o jogador e o veículo/caixa de som
  // Se essa distância for excedida, a música irá parar de tocar
  maxDistance: Infinity,

  dj: [
    {
      table: [120.81, -1280.32, 29.49],
      speaker: [112.71, -1287.38, 28.46],
      range: 50,
      volume: 100,
      permission: 'perm.user' 
    }
  ],

  range: { 
    // Todos os números podem ser substituidos por [range, volume]
    // ex: [48, 100] -> 48 metros com 100% de volume
    // Por padrão, o script entende que um número sozinho é o alcance em metros, e o volume será 100%
    vehicle: {
      '*': 48, // Padrão (48 metros & 100% de volume)
      'saveiro': [100,150], // (24 metros & 50% de volume)
      'amarokreb': [100,150], // Alcance e volume iguais;
      'ingot': [100,150], // Alcance e volume iguais;
      'g7cross': [100,150], // Alcance e volume iguais;
      'superd': [100,150], // Alcance e volume iguais;
      'pbus2': [100,150], // Alcance e volume iguais;
      'carreta': [100,150], // Alcance e volume iguais;
    },

    // radio é a JBL, quando a música tocar fora de um veículo
    radio: [20, 100], // (20 metros & 50% de volume)
  },
  blacklist: ['spawn_do_veiculo'],
  allowBluetoothOnBikes: false,
}