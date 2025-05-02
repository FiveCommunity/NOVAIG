Shops = {
    [1] = { amount = 5000, buyed = false, price = 100000 },
    [2] = { amount = 10000, buyed = false, price = 250000 },
    [3] = { amount = 20000, buyed = false, price = 500000 },
    [4] = { amount = 30000, buyed = false, price = 1000000 },
    [5] = { amount = 50000, buyed = false, price = 2500000 },
    [6] = { amount = 100000, buyed = false, price = 5000000 },
    [7] = { amount = 500000, buyed = false, price = 10000000 },
} 

CraftConfig = {
    Tables = {
-------------- [ DOMINAS ] --------------

        ['Dominacao [ARMAS]'] = {
            Config = {
                hasDominas = 'Armas',
                permission = 'perm.gerentearma',
                location = vec3(583.53,-3110.94,6.07)
            },

            Itens = {
                {
                    item = "WEAPON_APPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },

                {
                    item = "WEAPON_SMG_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "pecadearma" , amount = 515 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },

                {
                    item = "WEAPON_MICROSMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "pecadearma" , amount = 415 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Dominacao [MUNICAO]'] = {
            Config = {
                hasDominas = 'Municao',
                permission = 'perm.craftmuni',
                location = vec3(121.18,-3103.78,6.02)
            },
        
            Itens = {
                {
                    item = "AMMO_SMG_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 300 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 200 },  
                    }
                },
        
                {
                    item = "AMMO_APPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 300 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 200 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
        
                {
                    item = "AMMO_MICROSMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 300 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 200   },  
                        { item = "money" , amount = 15000 },  
                    }
                },
            }
        },


        ['Dominacao [GERAL]'] = {
            Config = {
                hasDominas = 'Geral',
                permission = nil,
                location = vec3(2755.67,1548.32,30.82)
            },

            Itens = {
                {
                    item = "WEAPON_PUMPSHOTGUN_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "money" , amount = 10000000 },
                    }
                },

                {
                    item = "AMMO_PUMPSHOTGUN_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "money" , amount = 1000000 },
                    }
                },

                {
                    item = "cogumelo", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "money" , amount = 20000 },
                    }
                },

                {
                    item = "barricada", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "money" , amount = 100000 },
                    }
                },
                {
                    item = "WEAPON_CARBINERIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "money" , amount = 2000000 },
                    }
                },

                {
                    item = "AMMO_CARBINERIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "money" , amount = 300000 },
                    }
                },
            }
        },
       
        ['Dominacao [LAVAGEM]'] = {
            Config = {
                hasDominas = 'Lavagem',
                permission = 'perm.craftlavagem',
                location = vec3(-446.58,-2642.07,8.76)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 180000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },

            }
        },

        ['Dominacao [DROGAS]'] = {
            Config = {
                hasDominas = 'Drogas',
                permission = 'perm.craftdrogas',
                location = vec3(690.27,588.41,131.06)
            },

            Itens = {
                {
                    item = "adrenalina", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "money" , amount = 50000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },

            }
        },

        ['Dominacao [DESMANCHE]'] = {
           Config = {
               hasDominas = 'Desmanche',
               permission = 'perm.craftdesmanche',
               location = vec3(-538.14,5288.33,75.35)
           },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 30 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 30 }  
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 130 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 130 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 10 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "aluminio" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "money" , amount = 30000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 15 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 15 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 15 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },

           }
        },
        
-------------- [ MESAS ] --------------
        -- HAXIXE

        -- ARMAS
        ['Mafia'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidermafia',
                location = vec3(-1866.9,2061.34,135.44)
            },
            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )                    }
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },


        ['Corleone'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidercorleone',
                location = vec3(391.14,-10.52,86.68)
            },
            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )                    }
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },

        ['Hospicio'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderhospicio",
                location = vec3(1401.41,1129.82,109.7)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },

        ['Inglaterra'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lideringlaterra',
                location = vec3(-1530.15,148.77,60.79)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },
    
        ['CV'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidercv',
                location = vec3(3039.00586, 2967.3916, 89.74857)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },
        ['Magnatas'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidermagnatas',
                location = vec3(-2997.2,69.39,16.23)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },
        ['Milicia'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidermilicia',
                location = vec3(-3097.13,1722.56,36.13)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },
        ['Alemanha'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lideralemanha',
                location = vec3(-886.97,-52.66,38.05)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },
        ['Grota'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidergrota',
                location = vec3(1236.94531, -105.298347, 74.78424)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                }
            }
        },
        ['China'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.gerentechina',
                location = vec3(-825.45,-723.82,23.78)
            },

            Itens = {
                {
                    item = "WEAPON_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pecadearma" , amount = 65, }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 105 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 215 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 265 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
        
                {
                    item = "WEAPON_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 250 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 295 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },  
                
                {
                    item = "WEAPON_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 420 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 395 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                
                {
                    item = "WEAPON_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]    
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
    
                    requires = {
                        { item = "pecadearma" , amount = 395 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        -- MUNICAOf
        ['Franca'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderfranca",
                location = vec3(1397.94,-767.27,67.18)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_HEAYVRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },

        ['Vaticano'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidervaticano",
                location = vec3(-1486.27,835.93,176.99)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_HEAYVRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },

        ['Pcc'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderpcc",
                location = vec3(-75.73,1004.46,239.5)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },

        ['Medellin'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidermedellin",
                location = vec3(332.54,-2014.23,22.65)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },

        ['Yakuza'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lideryakuza",
                location = vec3(-877.04,-1448.84,7.89)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },

          -- MUNICAO
          ['Korea'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderkorea",
                location = vec3(-1048.44,299.03,62.21)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },
        
        ['ADA'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderada",
                location = vec3(1232.39,-1042.4,46.89)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },
        ['Mexico'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidermexico',
                location = vec3(797.61,-223.26,66.37)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },
        ['Bratva'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.liderbratva',
                location = vec3(-2677.19,1336.48,152.02)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },
       

        ['Egito'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lideregito',
                location = vec3(-1653.75,-263.7,58.99)
            },

            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },
        ['Okayda'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.gerenteokayda',
                location = vec3(-3205.78,795.3,8.93),
                Max = 10000000,
            },

            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },
        ['Espanha'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.liderespanha',
                location = vec3(1361.79,1914.56,102.55)
            },

            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },

        -- DESMANCHE
        ['Escocia'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.liderescocia',
                location = vec3(1391.89,-2532.52,55.03)
            },
            Itens = {
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        ['Bennys'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderbennys",
                location = vec3(-242.57,-1326.22,30.89)
            },
            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        
        ['Cohab'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidercohab',
                location = vec3(-1556.72,-376.36,48.04)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },

        ['Roxos'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.liderroxos',
                location = vec3(90.49,-1990.06,20.41)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        ['SonsofAnarchy'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidersonsofanarchy',
                location = vec3(2515.13,4098.64,35.59)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        ['HellsAngels'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.liderhellsangels',
                location = vec3(1037.16,-2527.51,28.29)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        ['Motoclube'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidermotoclube',
                location = vec3(972.93,-98.61,74.34)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        ['CDD'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.lidercdd',
                location = vec3(-1188.43,-1729.96,11.9)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        ['Pedreira'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.liderpedreira',
                location = vec3(1567.92,-2165.89,77.56)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },
        ['Lacoste'] = {
            Config = {
                hasDominas = nil,
                permission = 'perm.gerentelacoste',
                location = vec3(737.6,-1088.78,22.16)
            },

            Itens = {
                {
                    item = "lockpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 }  
                    }
                },
                {
                    item = "c4", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "ferro" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "masterpick", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 5,
        
                    requires = {
                        { item = "ferro" , amount = 170 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 170 }  
                    }
                },
                {
                    item = "ticket", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "papel" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "garrafanitro", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 50 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 50 },
                        { item = "money" , amount = 50000 }
                    }
                },
                {
                    item = "body_armor", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 60 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 60 }  
                    }
                },
            }
        },

-------------- [ LAVAGEM SEM DOMINACAO ]------------------------
        ['Sete'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidersete",
                location = vec3(-1134.51,366.89,71.31)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 160000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },
                {
                    item = "capuz", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 20 }  
                    }
                },

                {
                    item = "corda", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "fibradecarbono" , amount = 25 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 25 }  
                    }
                },

                {
                    item = "algemas", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 40 }  
                    }
                },
            }
        },
        ['Anubis'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lideranubis",
                location = vec3(-436.2,-46.2,46.19)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 160000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },
                {
                    item = "capuz", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 20 }  
                    }
                },

                {
                    item = "corda", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "fibradecarbono" , amount = 25 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 25 }  
                    }
                },

                {
                    item = "algemas", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)

                    requires = {
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 40 }  
                    }
                },
            }
        },
        ['Bahamas'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderbahamas",
                location = vec3(-1384.97,-603.21,36.51)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 160000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },
                {
                    item = "capuz", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 20 }  
                    }
                },

                {
                    item = "corda", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 25 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 25 }  
                    }
                },

                {
                    item = "algemas", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 40 }  
                    }
                },
            }
        },
        ['Lux'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderlux",
                location = vec3(-281.73,223.55,78.82)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 160000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },
                {
                    item = "capuz", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 20 }  
                    }
                },

                {
                    item = "corda", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 25 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 25 }  
                    }
                },

                {
                    item = "algemas", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 40 }  
                    }
                },
            }
        },
        ['Cassino'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidercassino",
                location = vec3(956.42,20.93,75.74)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 160000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },
                {
                    item = "capuz", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 20 }  
                    }
                },

                {
                    item = "corda", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 25 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 25 }  
                    }
                },

                {
                    item = "algemas", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 40 }  
                    }
                },
            }
        },
        ['Tequila'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidertequila",
                location = vec3(-570.58,278.17,77.68)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 160000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },
                {
                    item = "capuz", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 20 }  
                    }
                },

                {
                    item = "corda", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 25 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 25 }  
                    }
                },

                {
                    item = "algemas", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 40 }  
                    }
                },
            }
        },

        ['Anonymous'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lideranonymous",
                location = vec3(413.25,-1500.85,33.8)
            },

            Itens = {
                {
                    item = "money", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 160000, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "dirty_money" , amount = 200000 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "l-alvejante" , amount = 20 }  
                    }
                },
                {
                    item = "capuz", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 20 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 20 }  
                    }
                },

                {
                    item = "corda", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "fibradecarbono" , amount = 25 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "poliester" , amount = 25 }  
                    }
                },

                {
                    item = "algemas", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "ferro" , amount = 40 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "aluminio" , amount = 40 }  
                    }
                },
            }
        },

-------------- [ OUTROS ] --------------            
        -- MACONHA

        -- BALINHA E HAXIXE
        ['Suecia'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidersuecia",
                location = vec3(1858.04,768.08,228.13)
            },
            Itens = {
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "haxixe", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "resinacannabis" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Elements'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.gerenteelements",
                location = vec3(-136.11,-1608.75,35.03)
            },
            Itens = {
                {
                    item = "metanfetamina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "anfetamina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "lancaperfume", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "respingodesolda" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "haxixe", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "resinacannabis" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "cocaina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pastabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Medusa'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidermedusa",
                location = vec3(753.92,-581.35,33.63)
            },
            Itens = {
                {
                    item = "metanfetamina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "anfetamina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "lancaperfume", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "respingodesolda" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "haxixe", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "resinacannabis" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "cocaina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pastabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },


        ['Italia'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.gerenteitalia",
                location = vec3(718.82,-960.0,30.41)
            },
            Itens = {
                {
                    item = "metanfetamina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "anfetamina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "lancaperfume", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "respingodesolda" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "haxixe", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "resinacannabis" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "cocaina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pastabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Abutres'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderabutres",
                location = vec3(2435.91,4965.49,42.34)
            },
            Itens = {
                {
                    item = "metanfetamina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "anfetamina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "lancaperfume", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "respingodesolda" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "haxixe", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "resinacannabis" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "cocaina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pastabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },


        ['Grecia'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.grecia",
                location = vec3(-338.96,-1519.64,33.19)
            },
            Itens = {
                {
                    item = "maconha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "folhamaconha" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "heroina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "morfina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "opio", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "opiopapoula" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        -- META | LANÇA | HAXIXE | COCAINA
        ['Israel'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderisrael",
                location = vec3(-1708.97,621.45,181.52)
            },
            Itens = {
                {
                    item = "metanfetamina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "anfetamina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "lancaperfume", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "respingodesolda" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "haxixe", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "resinacannabis" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "cocaina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pastabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },
        
        -- MACONHA | HEROINA | OPIO | BALINHA

        ['Irlanda'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderirlanda",
                location = vec3(-2254.19,-266.84,63.51)
            },

            Itens = {
                {
                    item = "maconha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "folhamaconha" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "heroina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "morfina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "opio", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "opiopapoula" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Psico'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderpsico",
                location = vec3(-2585.63,1904.04,167.49)
            },

            Itens = {
                {
                    item = "maconha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "folhamaconha" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "heroina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "morfina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "opio", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "opiopapoula" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Sindicato'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.gerentesindicato",
                location = vec3(-618.29,-1628.29,33.03) 
            },

            Itens = {
                {
                    item = "maconha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "folhamaconha" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "heroina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "morfina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "opio", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "opiopapoula" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },
        ['Taliba'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.gerentetaliba",
                location = vec3(-234.9,-1999.06,24.68)
            },

            Itens = {
                {
                    item = "maconha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "folhamaconha" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "heroina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "morfina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "opio", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "opiopapoula" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Palestina'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderpalestina",
                location = vec3(-498.88,-1477.47,19.28)
            },
            Itens = {
                {
                    item = "maconha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "folhamaconha" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "heroina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "morfina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "opio", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "opiopapoula" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },
        -- MACONHA E COCAINA
              
        ['Russia'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.gerenterussia",
                location = vec3(905.29,370.33,112.56)
            },

            Itens = {
                {
                    item = "metanfetamina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "anfetamina" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "lancaperfume", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "respingodesolda" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "haxixe", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "resinacannabis" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
                {
                    item = "cocaina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pastabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Vermelhos'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidervermelhos",
                location = vec3(-1063.0,-1662.4,4.55)
            },

            Itens = {
                {
                    item = "maconha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "folhamaconha" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },

                {
                    item = "cocaina", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "pastabase" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },
       
        
        ['Noruega'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.baulidernoruega",
                location = vec3(2200.0,20.02,250.57)
            },

            Itens = {
                {
                    item = "balinha", -- SPAWN DO ITEM
                    time = 3, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 2, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "podemd" , amount = 1 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                    }
                },
            }
        },

        ['Colombia'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.lidercolombia",
                location = vec3(-803.43,185.74,72.61)
            },
            Itens = {
                {
                    item = "AMMO_SNSPISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 75 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_PISTOL_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 }  
                    }
                },

                {
                    item = "AMMO_ASSAULTRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 5000 },  
                    }
                },
                
                {
                    item = "AMMO_SMG", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                
                {
                    item = "AMMO_MACHINEPISTOL", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 10000 },  
                    }
                },
                 
                {
                    item = "AMMO_ASSAULTRIFLE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 15000 },  
                    }
                },
                
                {
                    item = "AMMO_SPECIALCARBINE_MK2", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
                
                {
                    item = "AMMO_TACTICALRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },

                {
                    item = "AMMO_HEAVYRIFLE", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 100, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
        
                    requires = {
                        { item = "polvora" , amount = 150 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "capsulas" , amount = 100 },  
                        { item = "money" , amount = 30000 },  
                    }
                },
            }
        },

        ['Hospital'] = {
            Config = {
                hasDominas = nil,
                permission = "perm.liderunizk",
                location = vec3(1135.3,-1564.77,35.38)
            },
            Itens = {
                {
                    item = "flordelotus", -- SPAWN DO ITEM
                    time = 7, -- Tempo de craft por Unidade [ em segundos ]
                    customAmount = 1, -- Oque cada unidade vai fabricar
                    anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- ANIMAÇÃO DURANTE O CRAFT. (SE O TEMPO ESTIVER 0 DESCONSIDERAR)
                    maxItems = 30,
        
                    requires = {
                        { item = "riopan" , amount = 100 }, -- ITEM / QUANTIDADE ( POR UNIDADE )
                        { item = "coumadin" , amount = 100 }  
                    }
                },
            }
        },
    },

    Storage = {
        -- ARMAS
        ['Corleone'] = {
            Config = {
                permission = 'perm.corleone',
                location = vec3(407.27,2.5,84.92),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
                ["money"] = 1000000,
            }
        },
        ['Mafia'] = {
            Config = {
                permission = 'perm.mafia',
                location = vec3(-1866.35,2059.96,140.97),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
                ["money"] = 1000000,
            }
        },
        ['Hospicio'] = {
            Config = {
                permission = 'perm.hospicio',
                location = vec3(1392.12,1139.16,109.74),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['money'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
            },
            Max = 2000000
        },
        ['Inglaterra'] = {
            Config = {
                permission = 'perm.inglaterra',
                location = vec3(-1519.59,72.39,56.75),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
                ['money'] = 1000000,
            }
        },
        ['Magnatas'] = {
            Config = {
                permission = 'perm.magnatas',
                location = vec3(-2933.74,36.65,11.61),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
                ["money"] = 1000000,
            }
        },
        ['CV'] = {
            Config = {
                permission = 'perm.cv',
                location = vec3(3039.39355, 2971.51758, 89.82757),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
                ["money"] = 1000000,
            }
        },
        ['Milicia'] = {
            Config = {
                permission = 'perm.milicia',
                location = vec3(-3101.12,1731.53,36.13),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
            }
        },


        ['Alemanha'] = {
            Config = {
                permission = 'perm.alemanha',
                location = vec3(-844.14,-29.64,39.65),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
            }
        },

        ['Grota'] = {
            Config = {
                permission = 'perm.grota',
                location = vec3(1243.06482, -109.578613, 74.88578),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ["money"] = 1000000,
                ['metal'] = 1000000,
            },
            Max = 710000
        },

        ['China'] = {
            Config = {
                permission = 'perm.china',
                location = vec3(-824.38,-716.4,23.78),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ["money"] = 1000000,
                ['metal'] = 1000000,
            },
            Max = 710000
        },
      
        ['Helipa'] = {
            Config = {
                permission = 'perm.helipa',
                location = vec3(1421.89,-767.74,71.71),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pecadearma'] = 1000000,
                ['gatilho'] = 1000000,
                ['molas'] = 1000000,
                ['metal'] = 1000000,
            }
        },

        -- MUNIÇÃO
        ['Korea'] = {
            Config = {
                permission = 'perm.korea',
                location = vec3(-1025.43,304.95,66.99),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 500000,
        },
        ['Vaticano'] = {
            Config = {
                permission = 'perm.vaticano',
                location = vec3(-1509.41,837.5,181.59),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 500000,
        },
        ['Franca'] = {
            Config = {
                permission = 'perm.franca',
                location = vec3(1385.33,-717.5,67.62),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 500000,
        },
        ['Pcc'] = {
            Config = {
                permission = 'perm.pcc',
                location = vec3(-101.16,995.29,235.75),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 500000,
        },
        ['Medellin'] = {
            Config = {
                permission = 'perm.medellin',
                location = vec3(362.68,-2044.02,22.22),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 500000,
        },
        ['Yakuza'] = {
            Config = {
                permission = 'perm.yakuza',
                location = vec3(-902.78,-1446.11,7.53),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 500000,
        },
        ['Mexico'] = {
            Config = {
                permission = 'perm.mexico',
                location = vec3(691.98,-352.69,43.42),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            }
        },
        ['Bratva'] = {
            Config = {
                permission = 'perm.bratva',
                location = vec3(-2677.06,1314.26,147.44),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            }
        },
        ['Egito'] = {
            Config = {
                permission = 'perm.egito',
                location = vec3(-1642.31,-196.91,55.27),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            }
        },
        ['Okayda'] = {
            Config = {
                permission = 'perm.okayda',
                location = vec3(-3194.94,834.72,8.96),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 2000000,
        },
        ['Espanha'] = {
            Config = {
                permission = 'perm.espanha',
                location = vec3(1387.02,1913.83,102.31),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            }
        },

        -- DESMANCHE
        ['Escocia'] = {
            Config = {
                permission = 'perm.escocia',
                location = vec3(1393.14,-2539.88,55.15),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            }
        },
        ['Roxos'] = {
            Config = {
                permission = 'perm.roxos',
                location = vec3(108.41,-1982.42,20.96),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            }
        },
        ['Cohab'] = {
            Config = {
                permission = 'perm.cohab',
                location = vec3(-1569.71,-398.29,42.38),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            },
            Max = 710000
        },

        ['SonsofAnarchy'] = {
            Config = {
                permission = 'perm.sonsofanarchy',
                location = vec3(2513.2,4097.91,35.59),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            }
        },
        ['HellsAngels'] = {
            Config = {
                permission = 'perm.hellsangels',
                location = vec3(1035.42,-2516.72,28.29),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            }
        },
        ['Motoclube'] = {
            Config = {
                permission = 'perm.motoclube',
                location = vec3(964.61,-118.32,74.34),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            },
            Max = 1000000
        },
        ['CDD'] = {
            Config = {
                permission = 'perm.cdd',
                location = vec3(-1181.92,-1736.41,11.9),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            },
            Max = 1000000
        },
        ['Pedreira'] = {
            Config = {
                permission = 'perm.pedreira',
                location = vec3(1715.13,-2083.05,110.74),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            }
        },
        ['Bennys'] = {
            Config = {
                permission = 'perm.bennys',
                location = vec3(-223.96,-1319.97,30.89),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            }
        },
        ['Lacoste'] = {
            Config = {
                permission = 'perm.lacoste',
                location = vec3(726.9,-1064.04,22.16),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
                ['papel'] = 1000000,
                ['money'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000,
            }
        },

        -- LAVAGEM
        ['Sete'] = {
            Config = {
                permission = 'perm.sete',
                location = vec3(-1143.65,369.12,71.31),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['dirty_money'] = 1000000,
                ['l-alvejante'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                ['ferro'] = 1000000,
                ["money"] = 1000000,
                ['aluminio'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 500000
        },
        ['Anubis'] = {
            Config = {
                permission = 'perm.anubis',
                location = vec3(-443.7,-35.36,46.19),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['dirty_money'] = 1000000,
                ['l-alvejante'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                ['ferro'] = 1000000,
                ["money"] = 1000000,
                ['aluminio'] = 1000000,
            }
        },
        ['Lux'] = {
            Config = {
                permission = 'perm.lux',
                location = vec3(-286.47,232.78,78.82),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['dirty_money'] = 1000000,
                ['l-alvejante'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                ['ferro'] = 1000000,
                ["money"] = 1000000,
                ['aluminio'] = 1000000,
            },
            Max = 710000,
        },
        ['Anonymous'] = {
            Config = {
                permission = 'perm.anonymous',
                location = vec3(418.51,-1503.05,30.14),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['dirty_money'] = 1000000,
                ['l-alvejante'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                ["money"] = 1000000,
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
            }
        },
        ['Bahamas'] = {
            Config = {
                permission = 'perm.bahamas',
                location = vec3(-1389.77,-606.73,30.31),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['dirty_money'] = 1000000,
                ['l-alvejante'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                ["money"] = 1000000,
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
            }
        },
        ['Tequila'] = {
            Config = {
                permission = 'perm.tequila',
                location = vec3(-577.09,286.32,79.18),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['dirty_money'] = 1000000,
                ['l-alvejante'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                ['ferro'] = 1000000,
                ["money"] = 1000000,
                ['aluminio'] = 1000000,
                ['money'] = 1000000,
            }
        },
        ['Cassino'] = {
            Config = {
                permission = 'perm.cassino',
                location = vec3(961.02,13.77,75.74),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['dirty_money'] = 1000000,
                ['l-alvejante'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                ["money"] = 1000000,
                ['ferro'] = 1000000,
                ['aluminio'] = 1000000,
            },
            Max = 500000
        },

        -- BALINHA E HAXIXE
        ['Suecia'] = {
            Config = {
                permission = 'perm.suecia',
                location = vec3(1860.39,765.05,228.13),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['podemd'] = 1000000,
                ['resinacannabis'] = 1000000,
                
            }
        },
        ['Hamas'] = {
            Config = {
                permission = 'perm.hamas',
                location = vec3(2092.92,2328.35,101.67),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['podemd'] = 1000000,
                ['resinacannabis'] = 1000000,
            }
        },
        ['Abutres'] = {
            Config = {
                permission = 'perm.abutres',
                location = vec3(2433.97,4963.57,42.34),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                -- META
                ['anfetamina'] = 1000000,
                -- LANÇA
                ['respingodesolda'] = 1000000,
                -- HAXIXE
                ['resinacannabis'] = 1000000,
                -- COCAINA
                ['pastabase'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 100000
        },
        ['Elements'] = {
            Config = {
                permission = 'perm.elements',
                location = vec3(-133.7,-1609.75,35.03),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                -- META
                ['anfetamina'] = 1000000,
                -- LANÇA
                ['respingodesolda'] = 1000000,
                -- HAXIXE
                ['resinacannabis'] = 1000000,
                -- COCAINA
                ['pastabase'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 100000
        },
        ['Italia'] = {
            Config = {
                permission = 'perm.italia',
                location = vec3(715.71,-973.97,30.4),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                -- META
                ['anfetamina'] = 1000000,
                -- LANÇA
                ['respingodesolda'] = 1000000,
                -- HAXIXE
                ['resinacannabis'] = 1000000,
                -- COCAINA
                ['pastabase'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 100000
        },
        ['Medusa'] = {
            Config = {
                permission = 'perm.medusa',
                location = vec3(749.57,-550.76,33.63),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                -- META
                ['anfetamina'] = 1000000,
                -- LANÇA
                ['respingodesolda'] = 1000000,
                -- HAXIXE
                ['resinacannabis'] = 1000000,
                -- COCAINA
                ['pastabase'] = 1000000,
                ['money'] = 1000000,
            },
            Max = 100000
        },
        ['Grecia'] = {
            Config = {
                permission = 'perm.grecia',
                location = vec3(-329.2,-1522.15,28.22),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                -- HEROINA
                ['morfina'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                -- MACONHA
                ['folhamaconha'] = 1000000,
                -- OPIO 
                ['opiopapoula'] = 1000000,
                -- BALINHA
                ['podemd'] = 1000000,
                ['anfetamina'] = 1000000,
                ['money'] = 1000000,
                ['resinacannabis'] = 1000000,
            },
            Max = 710000
        },
        -- OPIO E HEROINA
         -- MACONHA | HEROINA | OPIO | BALINHA

         ['Irlanda'] = {
            Config = {
                permission = 'perm.irlanda',
                location = vec3(-2255.93,-270.89,63.51),
            },
            List = {
                -- HEROINA
                ['morfina'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                -- MACONHA
                ['folhamaconha'] = 1000000,
                -- OPIO 
                ['opiopapoula'] = 1000000,
                -- BALINHA
                ['podemd'] = 1000000,
                ['money'] = 1000000,
            }
        },
        ['Psico'] = {
            Config = {
                permission = 'perm.psico',
                location = vec3(-2602.98,1919.46,167.3),
            },
            List = {
                -- HEROINA
                ['morfina'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                -- MACONHA
                ['folhamaconha'] = 1000000,
                -- OPIO 
                ['opiopapoula'] = 1000000,
                -- BALINHA
                ['podemd'] = 1000000,
                ['money'] = 1000000,
            }
        },
        ['Sindicato'] = {
            Config = {
                permission = 'perm.sindicato',
                location = vec3(-612.01,-1613.88,27.01),
            },
            List = {
                -- HEROINA
                ['morfina'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                -- MACONHA
                ['folhamaconha'] = 1000000,
                -- OPIO 
                ['opiopapoula'] = 1000000,
                -- BALINHA
                ['podemd'] = 1000000,
                ['money'] = 1000000,
            },
        },
        ['Taliba'] = {
            Config = {
                permission = 'perm.taliba',
                location = vec3(-261.77,-2012.7,30.14),
            },
            List = {
                -- HEROINA
                ['morfina'] = 1000000,
                ['poliester'] = 1000000,
                ['fibradecarbono'] = 1000000, 
                -- MACONHA
                ['folhamaconha'] = 1000000,
                -- OPIO 
                ['opiopapoula'] = 1000000,
                -- BALINHA
                ['podemd'] = 1000000,
                ['money'] = 1000000,
            }
        },
        -- META | LANÇA | HAXIXE | COCAINA
        ['Israel'] = {
            Config = {
                permission = 'perm.israel',
                location = vec3(-1664.82,595.14,160.49),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                -- META
                ['anfetamina'] = 1000000,
                -- LANÇA
                ['respingodesolda'] = 1000000,
                -- HAXIXE
                ['resinacannabis'] = 1000000,
                -- COCAINA
                ['pastabase'] = 1000000,
                ['money'] = 1000000,
            }
        },

        -- MACONHA E COCAINA
        ['Russia'] = {
            Config = {
                permission = 'perm.russia',
                location = vec3(903.59,366.57,112.56),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                -- META
                ['anfetamina'] = 1000000,
                -- LANÇA
                ['respingodesolda'] = 1000000,
                -- HAXIXE
                ['resinacannabis'] = 1000000,
                -- COCAINA
                ['pastabase'] = 1000000,
                ['money'] = 1000000,
            },
        },
        ['Vermelhos'] = {
            Config = {
                permission = 'perm.vermelhos',
                location = vec3(-1080.36,-1671.34,4.7),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['pastabase'] = 1000000,
                ['folhamaconha'] = 1000000,

            }
        },
        ['Noruega'] = {
            Config = {
                permission = 'perm.noruega',
                location = vec3(2200.33,14.96,247.49),
            },

            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['podemd'] = 1000000,
            }
        },

        ['Colombia'] = {
            Config = {
                permission = 'perm.colombia',
                location = vec3(-812.22,177.88,76.73),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['polvora'] = 1000000,
                ['capsulas'] = 1000000,
                ['money'] = 1000000,
            }
        },

        ['Hospital'] = {
            Config = {
                permission = 'perm.unizk',
                location = vec3(1140.08,-1562.09,35.38),
            },
            List = {
                -- ITEM / QUANTIDADE MAXIMA
                ['riopan'] = 1000000,
                ['coumadin'] = 1000000,
            }
        },
    },
}

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end