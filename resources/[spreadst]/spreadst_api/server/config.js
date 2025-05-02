exports = {
  port: 2007,
  routes: [
    {
      method: 'post',
      path: '/v1/whitelist',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return res.status(400).json({ error: true })
        
        emit("spreadst_api:whitelist", req.body, (callback) => { res.json(callback) })
      },
    },
    {
      method: 'post',
      path: '/v1/status',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit('spreadst_api:status', req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/checkPlayer',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("JohnLogs:checkPlayer", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/webhook',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:updateWebhook", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/addcar',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:addcar", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/remcar',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:remcar", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/listChests',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:listChests", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/addChest',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:addChest", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/remChest',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:remChest", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/updateChest',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:updateChest", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/updateChestCoords',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:updateChestCoords", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/updateChestWeight',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:updateChestWeight", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/listSkinShops',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:listSkinShops", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/addSkinsShop',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:addSkinsShop", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/removeSkinsShop',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:removeSkinsShop", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/listBarberShops',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:listBarberShops", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/addBarberShop',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:addBarberShop", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/removeBarberShop',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:removeBarberShop", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/listTattooShops',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:getTattooShops", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/addTattooShop',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:addTattooShop", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/removeTattooShop',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:removeTattooShop", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/listBanks',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:getBanks", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post', 
      path: '/v1/addBank',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:addBank", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/removeBank',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:removeBank", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/listConvenienceStores',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:getShops", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post', 
      path: '/v1/addConvenienceStore',
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:addShop", req.body, (callback) => { res.json(callback) })
      }
    },
    {
      method: 'post',
      path: '/v1/removeConvenienceStore', 
      exec: async (req, res) => {
        if (req.headers['api_token'] !== 'c4fa6ba9-c1d8-4f16-8236-b69bb8ed3f9a') return

        emit("lotus:removeShop", req.body, (callback) => { res.json(callback) })
      }
    },
  ]
}
