

Config = {}

Config.Main = {
    cmd = 'org', -- Comando para abrir Painel
    cmdAdm = 'orgadm', -- Comando para abrir Painel ADM
    createAutomaticOrganizations = true,
    storeUrl = 'https://fivecommunity.site', -- Link da Sua Loja
    serverLogo = 'https://cdn.discordapp.com/attachments/1343910480963698698/1344064291472408596/banner.png?ex=67e1d3ea&is=67e0826a&hm=5b130248009e54296a6a76d079080eafd0b9c7005606482cc3b42cd78132bbea&',
    blackListIlegal = 1,
    blackList = 1,
    clearChestLogs = 15, -- Logs do Bau limpar automaticamente de 15 em 15 dias. ( Evitar consumo da tabela )
}


Config.defaultPermissions = { 
    invite = { -- Permissao Para Convidar
        name = "Convidar",
        description = "Esta permissao permite vc convidar as pessoas para sua facção."
    },
    demote = { -- Permissao Para Rebaixar
        name = "Rebaixar",
        description = "Essa permissão permite que o cargo selecionado rebaixe um cargo inferior."
    }, 
    promote = { -- Permissao Para Promover
        name = "Promover",
        description = "Essa permissão permite que o cargo selecionado promova um cargo."
    }, 
    dismiss = { -- Permissao Para Rebaixar
        name = "Demitir",
        description = "Essa permissão permite que o cargo selecionado demita um cargo inferior."
    }, 
    withdraw = { -- Permissao Para Sacar Dinheiro
        name = "Sacar dinheiro",
        description = "Permite que esse cargo selecionado possa sacar dinheiro do banco da facção."
    }, 
    deposit = { -- Permissao Para Depositar Dinheiro
        name = "Depositar dinheiro",
        description = "Permite que esse cargo selecionado possa depositar dinheiro no banco da facção."
    }, 
    message = { -- Permissao para Escrever nas anotaçoes
        name = "Escrever anotações",
        description = "Permite que esse cargo selecionado possa escrever anotações."
    },
    alerts = { -- Permissao para enviar alertas
        name = "Escrever Alertas",
        description = "Permite que esse cargo selecionado possa enviar alertas para todos jogadores."
    },
    chat = { -- Permissao para Falar no chat
        name = "Escrever no chat",
        description = "Permite que esse cargo selecionado possa se comunicar no chat da facção"
    },
}

Config.Groups = {
    ['Mafia'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                    ["money"] = 1000000,

                }
            }
        },

        List = {
            ['Lider [MAFIA]'] = {
                prefix = 'Lider',
                tier = 1,
            },
            ['Sub-Lider [MAFIA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
            },
            ['Gerente [MAFIA]'] = {
                prefix = 'Gerente',
                tier = 3,
            },
            ['Recrutador [MAFIA]'] = {
                prefix = 'Recrutador',
                tier = 4,
            },
            ['Membro [MAFIA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [MAFIA]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['Magnatas'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                    ["money"] = 1000000,

                }
            }
        },

        List = {
            ['Lider [MAGNATAS]'] = {
                prefix = 'Lider',
                tier = 1,
            },
            ['Sub-Lider [MAGNATAS]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
            },
            ['Gerente [MAGNATAS]'] = {
                prefix = 'Gerente',
                tier = 3,
            },
            ['Recrutador [MAGNATAS]'] = {
                prefix = 'Recrutador',
                tier = 4,
            },
            ['Membro [MAGNATAS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [MAGNATAS]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['Grota'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 15000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                    ["money"] = 1000000,

                }
            }
        },

        List = {
            ['Lider [GROTA]'] = {
                prefix = 'Lider',
                tier = 1,
            },
            ['Sub-Lider [GROTA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
            },
            ['Gerente [GROTA]'] = {
                prefix = 'Gerente',
                tier = 3,
            },
            ['Recrutador [GROTA]'] = {
                prefix = 'Recrutador',
                tier = 4,
            },
            ['Membro [GROTA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [GROTA]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['China'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 15000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                    ["money"] = 1000000,

                }
            }
        },

        List = {
            ['Lider [CHINA]'] = {
                prefix = 'Lider',
                tier = 1,
            },
            ['Sub-Lider [CHINA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
            },
            ['Gerente [CHINA]'] = {
                prefix = 'Gerente',
                tier = 3,
            },
            ['Recrutador [CHINA]'] = {
                prefix = 'Recrutador',
                tier = 4,
            },
            ['Membro [CHINA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [CHINA]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['Hospicio'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                
                }
            }
        },

        List = {
            ['Lider [HOSPICIO]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [HOSPICIO]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [HOSPICIO]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [HOSPICIO]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [HOSPICIO]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [HOSPICIO]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['Inglaterra'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                    ["money"] = 1000000,
                
                }
            }
        },

        List = {
            ['Lider [INGLATERRA]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3
            },
            ['Sub-Lider [INGLATERRA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5
            },
            ['Gerente [INGLATERRA]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 10
            },
            ['Recrutador [INGLATERRA]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 15
            },
            ['Membro [INGLATERRA]'] = {
                prefix = 'Membro',
                tier = 5
            },
 
            ['Novato [INGLATERRA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['CV'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                    ["money"] = 1000000,
                
                }
            }
        },

        List = {
            ['Lider [CV]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [CV]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [CV]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [CV]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [CV]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [CV]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Franca'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,             
                }
            }
        },

        List = {
            ['Lider [FRANCA]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [FRANCA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [FRANCA]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 10,
            },
            ['Recrutador [FRANCA]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 15
            },
            ['Membro [FRANCA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [FRANCA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Pcc'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,             
                }
            }
        },

        List = {
            ['Lider [PCC]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [PCC]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [PCC]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 10,
            },
            ['Recrutador [PCC]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 15
            },
            ['Membro [PCC]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [PCC]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Milicia'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
    
                }
            }
        },

        List = {
            ['Lider [MILICIA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [MILICIA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [MILICIA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [MILICIA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [MILICIA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [MILICIA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Vaticano'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,
                }
            }
        },

        List = {
            ['Lider [VATICANO]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [VATICANO]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [VATICANO]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [VATICANO]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [VATICANO]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [VATICANO]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Corleone'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['money'] = 1000000,
                    ["pecadearma"] = 50,
                    ["money"] = 1000000,
                
                }
            }
        },

        List = {
            ['Lider [CORLEONE]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [CORLEONE]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [CORLEONE]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [CORLEONE]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [CORLEONE]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [CORLEONE]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    --[[MUNIÇÃO]]
   
    ['Egito'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,
                }
            }
        },

        List = {
            ['Lider [EGITO]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [EGITO]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [EGITO]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [EGITO]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [EGITO]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [EGITO]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Colombia'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,
                }
            }
        },

        List = {
            ['Lider [COLOMBIA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [COLOMBIA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [COLOMBIA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [COLOMBIA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [COLOMBIA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [COLOMBIA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Korea'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 15000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,
                }
            }
        },

        List = {
            ['Lider [KOREA]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3
            },
            ['Sub-Lider [KOREA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5
            },
            ['Gerente [KOREA]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 10
            },
            ['Recrutador [KOREA]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 15
            },
            ['Membro [KOREA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [KOREA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Okayda'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,          
                }
            }
        },

        List = {
            ['Lider [OKAYDA]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [OKAYDA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [OKAYDA]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 15,
            },
            ['Recrutador [OKAYDA]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 20,
            },
            ['Membro [OKAYDA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [OKAYDA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Medellin'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,          
                }
            }
        },

        List = {
            ['Lider [MEDELLIN]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [MEDELLIN]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [MEDELLIN]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 15,
            },
            ['Recrutador [MEDELLIN]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 20,
            },
            ['Membro [MEDELLIN]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [MEDELLIN]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Yakuza'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,
                    ['money'] = 50,          
                }
            }
        },

        List = {
            ['Lider [YAKUZA]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [YAKUZA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [YAKUZA]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 15,
            },
            ['Recrutador [YAKUZA]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 20,
            },
            ['Membro [YAKUZA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [YAKUZA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Mexico'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 15000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,               
                }
            }
        },

        List = {
            ['Lider [MEXICO]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [MEXICO]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [MEXICO]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 10,
            },
            ['Recrutador [MEXICO]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 15,
            },
            ['Membro [MEXICO]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [MEXICO]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Bratva'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 15000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,               
                }
            }
        },

        List = {
            ['Lider [BRATVA]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [BRATVA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [BRATVA]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 10,
            },
            ['Recrutador [BRATVA]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 15,
            },
            ['Membro [BRATVA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [BRATVA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['ADA'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 15000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['polvora'] = 50,
                    ['capsulas'] = 50,               
                }
            }
        },

        List = {
            ['Lider [ADA]'] = {
                prefix = 'Lider',
                tier = 1,
                maxSets = 3,
            },
            ['Sub-Lider [ADA]'] = {
                prefix = 'Sub-Lider',
                tier = 2,
                maxSets = 5,
            },
            ['Gerente [ADA]'] = {
                prefix = 'Gerente',
                tier = 3,
                maxSets = 10,
            },
            ['Recrutador [ADA]'] = {
                prefix = 'Recrutador',
                tier = 4,
                maxSets = 15,
            },
            ['Membro [ADA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ADA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    --[[LAVAGEM]]
    ['Tequila'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['l-alvejante'] = 50,
                    ['poliester'] = 50,
                    ['fibradecarbono'] = 50, 
                    ['ferro'] = 50,
                    ['aluminio'] = 50,     
                    ["money"] = 1000000,
                }
            }
        },

        List = {
            ['Lider [TEQUILA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [TEQUILA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [TEQUILA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [TEQUILA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [TEQUILA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [TEQUILA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Anonymous'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['l-alvejante'] = 50,
                    ['poliester'] = 50,
                    ['fibradecarbono'] = 50, 
                    ['ferro'] = 50,
                    ['aluminio'] = 50,   
                    ["money"] = 1000000,
                }
            }
        },

        List = {
            ['Lider [ANONYMOUS]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ANONYMOUS]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ANONYMOUS]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ANONYMOUS]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ANONYMOUS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ANONYMOUS]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Sete'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['l-alvejante'] = 50,
                    ['poliester'] = 50,
                    ['fibradecarbono'] = 50, 
                    ['ferro'] = 50,
                    ['aluminio'] = 50, 
                    ["money"] = 1000000,
                }
            }
        },

        List = {
            ['Lider [SETE]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [SETE]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [SETE]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [SETE]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [SETE]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [SETE]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Lux'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['l-alvejante'] = 50,
                    ['poliester'] = 50,
                    ['fibradecarbono'] = 50, 
                    ['ferro'] = 50,
                    ['aluminio'] = 50,     
                    ["money"] = 1000000,
                }
            }
        },

        List = {
            ['Lider [LUX]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [LUX]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [LUX]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [LUX]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [LUX]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [LUX]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Medusa'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['anfetamina'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['pastabase'] = 50,
                }
            }
        },

        List = {
            ['Lider [MEDUSA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [MEDUSA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [MEDUSA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [MEDUSA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [MEDUSA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [MEDUSA]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['Cassino'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['l-alvejante'] = 50,
                    ['poliester'] = 50,
                    ['fibradecarbono'] = 50, 
                    ['ferro'] = 50,
                    ['aluminio'] = 50,      
                    ["money"] = 1000000,
                }
            }
        },

        List = {
            ['Lider [CASSINO]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [CASSINO]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [CASSINO]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [CASSINO]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [CASSINO]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [CASSINO]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['Anubis'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['l-alvejante'] = 50,
                    ['poliester'] = 50,
                    ['fibradecarbono'] = 50, 
                    ['ferro'] = 50,
                    ['aluminio'] = 50,     
                    ["money"] = 1000000,
                }
            }
        },

        List = {
            ['Lider [ANUBIS]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ANUBIS]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ANUBIS]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ANUBIS]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ANUBIS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ANUBIS]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    ['Bahamas'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['l-alvejante'] = 50,
                    ['poliester'] = 50,
                    ['fibradecarbono'] = 50, 
                    ['ferro'] = 50,
                    ['aluminio'] = 50,     
                    ["money"] = 1000000,
                }
            }
        },

        List = {
            ['Lider [BAHAMAS]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [BAHAMAS]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [BAHAMAS]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [BAHAMAS]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [BAHAMAS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [BAHAMAS]'] = {
                prefix = 'Novato',
                tier = 6
            },

        }
    },
    --[[DESMANCHE]]
    ['Escocia'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['ferro'] = 1000000,
                    ['aluminio'] = 1000000,
                    ['papel'] = 1000000,
                    ['poliester'] = 1000000,
                    ['fibradecarbono'] = 1000000,
                }
            }
        },

        List = {
            ['Lider [ESCOCIA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ESCOCIA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ESCOCIA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ESCOCIA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ESCOCIA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ESCOCIA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Motoclube'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['ferro'] = 1000000,
                    ['aluminio'] = 1000000,
                    ['papel'] = 1000000,
                    ['poliester'] = 1000000,
                    ['fibradecarbono'] = 1000000,
                    
                }
            }
        },

        List = {
            ['Lider [MOTOCLUBE]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [MOTOCLUBE]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [MOTOCLUBE]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [MOTOCLUBE]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [MOTOCLUBE]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [MOTOCLUBE]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Lacoste'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['ferro'] = 1000000,
                    ['aluminio'] = 1000000,
                    ['papel'] = 1000000,
                    ['poliester'] = 1000000,
                    ['fibradecarbono'] = 1000000,
                    
                }
            }
        },

        List = {
            ['Lider [LACOSTE]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [LACOSTE]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [LACOSTE]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [LACOSTE]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [LACOSTE]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [LACOSTE]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['CDD'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['pastabase'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['ferro'] = 50,
                    ['aluminio'] = 50,
                }
            }
        },

        List = {
            ['Lider [CDD]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [CDD]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [CDD]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [CDD]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [CDD]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [CDD]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['HellsAngels'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['podemd'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                }
            }
        },

        List = {
            ['Lider [HELLSANGELS]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [HELLSANGELS]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [HELLSANGELS]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [HELLSANGELS]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [HELLSANGELS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [HELLSANGELS]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Pedreira'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['pastabase'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                }
            }
        },

        List = {
            ['Lider [PEDREIRA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [PEDREIRA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [PEDREIRA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [PEDREIRA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [PEDREIRA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [PEDREIRA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Roxos'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['pastabase'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                }
            }
        },

        List = {
            ['Lider [ROXOS]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ROXOS]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ROXOS]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ROXOS]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ROXOS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ROXOS]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Bennys'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['ferro'] = 1000000,
                    ['aluminio'] = 1000000,
                    ['papel'] = 1000000,
                    ['poliester'] = 1000000,
                    ['fibradecarbono'] = 1000000,
                }
            }
        },

        List = {
            ['Lider [BENNYS]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [BENNYS]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [BENNYS]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [BENNYS]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [BENNYS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [BENNYS]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Cohab'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['money'] = 1000000,
                    ['dirty_money'] = 1000000,
                    ['ferro'] = 1000000,
                    ['aluminio'] = 1000000,
                    ['papel'] = 1000000,
                    ['poliester'] = 1000000,
                    ['fibradecarbono'] = 1000000,
                }
            }
        },

        List = {
            ['Lider [COHAB]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [COHAB]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [COHAB]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [COHAB]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [COHAB]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [COHAB]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    
    --[[DROGAS]]

    ['Israel'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['anfetamina'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['pastabase'] = 50,
                }
            }
        },

        List = {
            ['Lider [ISRAEL]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ISRAEL]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ISRAEL]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ISRAEL]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ISRAEL]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ISRAEL]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Russia'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['anfetamina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['pastabase'] = 50,
                }
            }
        },

        List = {
            ['Lider [RUSSIA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [RUSSIA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [RUSSIA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [RUSSIA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [RUSSIA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [RUSSIA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Elements'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['anfetamina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['pastabase'] = 50,
                }
            }
        },

        List = {
            ['Lider [ELEMENTS]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ELEMENTS]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ELEMENTS]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ELEMENTS]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ELEMENTS]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ELEMENTS]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Italia'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['anfetamina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['pastabase'] = 50,
                }
            }
        },

        List = {
            ['Lider [ITALIA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ITALIA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ITALIA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ITALIA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ITALIA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ITALIA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Abutres'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['anfetamina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['pastabase'] = 50,
                }
            }
        },

        List = {
            ['Lider [ABUTRES]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [ABUTRES]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [ABUTRES]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [ABUTRES]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [ABUTRES]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [ABUTRES]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Irlanda'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['morfina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['podemd'] = 50,
                }
            }
        },

        List = {
            ['Lider [IRLANDA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [IRLANDA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [IRLANDA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [IRLANDA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [IRLANDA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [IRLANDA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    ['Psico'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['morfina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['podemd'] = 50,
                }
            }
        },

        List = {
            ['Lider [PSICO]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [PSICO]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [PSICO]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [PSICO]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [PSICO]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [PSICO]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Sindicato'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['morfina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['podemd'] = 50,
                }
            }
        },

        List = {
            ['Lider [SINDICATO]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [SINDICATO]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [SINDICATO]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [SINDICATO]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [SINDICATO]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [SINDICATO]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Taliba'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['morfina'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['podemd'] = 50,
                }
            }
        },

        List = {
            ['Lider [TALIBA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [TALIBA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [TALIBA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [TALIBA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [TALIBA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [TALIBA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Grecia'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['morfina'] = 50,
                    ['folhamaconha'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                    ['podemd'] = 50,
                }
            }
        },

        List = {
            ['Lider [GRECIA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [GRECIA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [GRECIA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [GRECIA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [GRECIA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [GRECIA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Palestina'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['dirty_money'] = 1000000,
                    ['podemd'] = 50,
                    ['folhamaconha'] = 50,
                    ['resinacannabis'] = 50,
                    ['opiopapoula'] = 50,
                    ['respingodesolda'] = 50,
                    ['fibradecarbono'] = 50,
                    ['poliester'] = 50,
                }
            }
        },

        List = {
            ['Lider [PALESTINA]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [PALESTINA]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [PALESTINA]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Recrutador [PALESTINA]'] = {
                prefix = 'Recrutador',
                tier = 4
            },
            ['Membro [PALESTINA]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [PALESTINA]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },
    
    ['Jornal'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['m-gatilho'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['m-corpo_microsmg'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },

        List = {
            ['DiretorJornal'] = {
                prefix = 'DiretorJornal',
                tier = 1
            },
            ['ProdutorJornal'] = {
                prefix = 'ProdutorJornal',
                tier = 2
            },
            ['Reporter'] = {
                prefix = 'Reporter',
                tier = 3
            },
            ['EstagiarioJornal'] = {
                prefix = 'EstagiarioJornal',
                tier = 4
            },
        }
    },

    ["Judiciario"] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['m-gatilho'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['m-corpo_microsmg'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
		
		List = {
			["Desembargador"] = {
				prefix = "Desembargador",
				tier = 1,
			},

			["Juiz"] = {
				prefix = "Juiz", 
				tier = 2, 
			},

			["Promotor"] = {
				prefix = "Promotor", 
				tier = 3,
			},

			["Supervisor"] = {
				prefix = "Supervisor",
				tier = 4, 
			},

			["Advogado"] = {
				prefix = "Advogado", 
				tier = 5,
			},
			["Seguranca"] = {
				prefix = "Seguranca", 
				tier = 6,
			},

			["EstagiarioADV"] = { 
				prefix = "EstagiarioADV",
				tier = 7, 
			},
		}
	},

    ["Vanilla"] = {
        Config = {
            Salary = {
                active = false,
                amount = 2000,
                time = 30,
            },
    
            Goals = { -- METAS
                defaultReward = 300,
                itens = {}
            }
        },
            
        List = {
            ["Lider [VANILLA]"] = {
                prefix = "Lider",
                tier = 1
            },
            ["Sub-Lider [VANILLA]"] = {
                prefix = "Sub-Lider",
                tier = 2
            },
            ["Gerente [VANILLA]"] = {
                prefix = "Gerente",
                tier = 3
            },
            ["Dancarina [VANILLA]"] = {
                prefix = "Dancarinas",
                tier = 4
            },
            ["Seguranca [VANILLA]"] = {
                prefix = "Seguranca",
                tier = 5
            }
        }
    },

    ["Bombeiro"] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['m-gatilho'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['m-corpo_microsmg'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
		
		List = {
			["CoronelBombeiro"] = {
				prefix = "CoronelBombeiro",
				tier = 1,
			},

			["TenenteCoronelBombeiro"] = {
				prefix = "TenenteCoronelBombeiro", 
				tier = 2, 
			},

			["MajorBombeiro"] = {
				prefix = "MajorBombeiro", 
				tier = 3,
			},

			["CapitaoBombeiro"] = {
				prefix = "CapitaoBombeiro",
				tier = 4, 
			},

			["TenenteBombeiro"] = {
				prefix = "TenenteBombeiro", 
				tier = 5,
			},

			["CaboBombeiro"] = { 
				prefix = "CaboBombeiro",
				tier = 6, 
			},
			
			["SoldadoBombeiro"] = {
				prefix = "SoldadoBombeiro", 
				tier = 7, 
			},
		}
	},

    ["BombeiroCivil"] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['m-gatilho'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['m-corpo_microsmg'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
		
		List = {
			["CoronelBombeiro [CIVIL]"] = {
				prefix = "CoronelBombeiro",
				tier = 1,
			},

			["TenenteCoronelBombeiro [CIVIL]"] = {
				prefix = "TenenteCoronelBombeiro", 
				tier = 2, 
			},

			["MajorBombeiro [CIVIL]"] = {
				prefix = "MajorBombeiro", 
				tier = 3,
			},

			["CapitaoBombeiro [CIVIL]"] = {
				prefix = "CapitaoBombeiro",
				tier = 4, 
			},

			["TenenteBombeiro [CIVIL]"] = {
				prefix = "TenenteBombeiro", 
				tier = 5,
			},

			["CaboBombeiro [CIVIL]"] = { 
				prefix = "CaboBombeiro",
				tier = 6, 
			},
			
			["SoldadoBombeiro [CIVIL]"] = {
				prefix = "SoldadoBombeiro", 
				tier = 7, 
			},
		}
	},

    ['Hospital'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['m-gatilho'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['m-corpo_microsmg'] = 50, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },

        List = {
            ['Diretor'] = {
                prefix = 'Diretor',
                tier = 1
            },
            ['ViceDiretor'] = {
                prefix = 'ViceDiretor',
                tier = 2
            },
            ['Gestao'] = {
                prefix = 'Gestao',
                tier = 3
            },
            ['Psiquiatra'] = {
                prefix = 'Psiquiatra',
                tier = 4
            },
            ['Medico'] = {
                prefix = 'Medico',
                tier = 5
            },
            ['Enfermeiro'] = {
                prefix = 'Enfermeiro',
                tier = 6
            },
            ['Socorrista'] = {
                prefix = 'Socorrista',
                tier = 7
            },
        }
    },

    ['Mecanica'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                }
            }
        },

        List = {
            ['Lider [Mecanica]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [Mecanica]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [Mecanica]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Membro [Mecanica]'] = {
                prefix = 'Membro',
                tier = 4
            },
            ['Novato [Mecanica]'] = {
                prefix = 'Novato',
                tier = 5
            },
            ['Recrutador [Mecanica]'] = {
                prefix = 'Recrutador',
                tier = 6
            },
        }
    },

    ['Deboxe'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                }
            }
        },

        List = {
            ['Lider [Deboxe]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [Deboxe]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [Deboxe]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Supervisor [Deboxe]'] = {
                prefix = 'Supervisor',
                tier = 4
            },
            ['Recrutador [Deboxe]'] = {
                prefix = 'Recrutador',
                tier = 5
            },
            ['Membro [Deboxe]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [Deboxe]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['StoMotors'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                }
            }
        },

        List = {
            ['Lider [StoMotors]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [StoMotors]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [StoMotors]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Supervisor [StoMotors]'] = {
                prefix = 'Supervisor',
                tier = 4
            },
            ['Recrutador [StoMotors]'] = {
                prefix = 'Recrutador',
                tier = 5
            },
            ['Membro [StoMotors]'] = {
                prefix = 'Membro',
                tier = 5
            },
            ['Novato [StoMotors]'] = {
                prefix = 'Novato',
                tier = 6
            },
        }
    },

    ['Sickomotors'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                }
            }
        },

        List = {
            ['Lider [Sickomotors]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [Sickomotors]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [Sickomotors]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Supervisor [Sickomotors]'] = {
                prefix = 'Supervisor',
                tier = 4
            },
            ['Recrutador [Sickomotors]'] = {
                prefix = 'Recrutador',
                tier = 5
            },
            ['Mecanico [Sickomotors]'] = {
                prefix = 'Mecanico',
                tier = 6
            },
        }
    },

    ['Race'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                }
            }
        },

        List = {
            ['Lider [Race]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [Race]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [Race]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Supervisor [Race]'] = {
                prefix = 'Supervisor',
                tier = 4
            },
            ['Recrutador [Race]'] = {
                prefix = 'Recrutador',
                tier = 5
            },
            ['Membro [Race]'] = {
                prefix = 'Membro',
                tier = 6
            },
            ['Novato [Race]'] = {
                prefix = 'Novato',
                tier = 7
            },
        }
    },

    ['Redline'] = {
        Config = {
            type = "legal",
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 2000, -- Valor que vai receber
                time = 30, -- tempo em tempo que vai receber salario em minuto(s)
            },

            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                }
            }
        },

        List = {
            ['Lider [Redline]'] = {
                prefix = 'Lider',
                tier = 1
            },
            ['Sub-Lider [Redline]'] = {
                prefix = 'Sub-Lider',
                tier = 2
            },
            ['Gerente [Redline]'] = {
                prefix = 'Gerente',
                tier = 3
            },
            ['Supervisor [Redline]'] = {
                prefix = 'Supervisor',
                tier = 4
            },
            ['Recrutador [Redline]'] = {
                prefix = 'Recrutador',
                tier = 5
            },
            ['Membro [Redline]'] = {
                prefix = 'Membro',
                tier = 6
            },
            ['Novato [Redline]'] = {
                prefix = 'Novato',
                tier = 7
            },
        }
    },
}
Config.Langs = {
    ['offlinePlayer'] = function(source) TriggerClientEvent("Notify", source,"negado","Este jogador não está online.",5000) end,
    ['alreadyFaction'] = function(source) TriggerClientEvent("Notify", source,"negado","Este jogador já esta em uma organização.",5000)  end,
    ['alreadyBlacklist'] = function(source) TriggerClientEvent("Notify", source,"negado","Você está na black-list, não pode receber convites.",5000)  end,
    ['alreadyUserBlacklist'] = function(source) TriggerClientEvent("Notify",source,"negado","Este jogador está em black-list.",5000)  end,
    ['sendInvite'] = function(source) TriggerClientEvent("Notify",source,"sucesso","Você enviou o convite.",5000)  end,
    ['acceptInvite'] = function(source) TriggerClientEvent("Notify",source,"sucesso","Você aceitou o convite.",5000) end,
    ['acceptedInvite'] = function(source, ply_id) TriggerClientEvent("Notify",source,"sucesso","O "..ply_id.." aceitou o convite. ",5000) end,
    ['bestTier'] = function(source) TriggerClientEvent("Notify",source,"negado","Você não pode fazer isso com alguem com um cargo igual ou maior que o seu.",5000)   end,
    ['youPromoved'] = function(source) TriggerClientEvent("Notify",source,"sucesso","Você foi promovido.",5000)  end,
    ['youPromovedUser'] = function(source, ply_id, group) TriggerClientEvent("Notify",source,"sucesso","Você promoveu o ID: "..ply_id.." para "..group..".",5000) end,
    ['youDemote'] = function(source) TriggerClientEvent("Notify",source,"sucesso","Você foi rebaixado.",5000)  end,
    ['youDemoteUser'] = function(source, ply_id, group) TriggerClientEvent("Notify",source,"sucesso","Você rebaixou o ID: "..ply_id.." para ".. group ..".",5000) end,
    ['youDismiss'] = function(source) TriggerClientEvent("Notify",source,"sucesso","Você foi demitido de sua organização .",5000)  end,
    ['youDismissUser'] = function(source, ply_id) TriggerClientEvent("Notify", source,"sucesso","Você demitiu o ID "..ply_id.." .",5000)  end,
    ['waitCooldown'] = function(source) TriggerClientEvent("Notify",source,"negado","Aguarde para fazer isso..",5000) end,
    ['bankNotMoney'] = function(source) TriggerClientEvent("Notify",source,"negado","O Banco da organização não possui essa quantia.",5000)  end,
    ['rewardedGoal'] = function(source, amount) TriggerClientEvent("Notify",source,"sucesso","Você resgatou sua meta diaria e recebeu <b>R$ "..amount.."</b> por isso.",5000) end,
    ['notPermission'] = function(source) TriggerClientEvent("Notify",source,"negado","Você não possui permissão.",5000)  end,
    ['notMoneyDeposit'] = function(source) TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro para depositar.",5000)  end

}

if SERVER then
    -- CUSTOM QUERYS
    vRP.prepare('mirtin_orgs_v2/GetUsersGroup', " SELECT user_id,dvalue FROM vrp_user_data WHERE dkey = 'vRP:datatable' ")
    vRP.prepare("mirtin_orgs_v2/getUserGroup", "SELECT user_id,dvalue FROM vrp_user_data WHERE dkey = 'vRP:datatable' and user_id = @user_id")
    vRP.prepare("mirtin_orgs_v2/updateUserGroup", "UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id and dkey = 'vRP:datatable'")

    -- CAPTURAR GRUPOS COM JOGADOR OFFLINE
    function getUserGroups(user_id)
        local rows = vRP.query("mirtin_orgs_v2/getUserGroup", { user_id = user_id })
        local data = json.decode(rows[1].dvalue) or {}

        if #rows == 0 then 
            return 
        end

        return data.groups
    end

    -- SETAR GRUPO COM JOGADOR OFFLINE
    function updateUserGroups(user_id, groups)
        local rows = vRP.query("mirtin_orgs_v2/getUserGroup", { user_id = user_id })
        local data = json.decode(rows[1].dvalue) or {}

        if #rows == 0 then 
            return 
        end

        if not groups then
            groups = {}
        end

        data.groups = groups

        vRP.execute("mirtin_orgs_v2/updateUserGroup", { user_id = user_id, dvalue = json.encode(data) })
    end

    -- PEGAR DINHEIRO DO BANCO DO JOGADOR
    function getBankMoney(user_id)
        return vRP.getBankMoney(user_id)
    end

    -- IDENTIDADE
    function getUserIdentity(user_id)
        local identity = vRP.getUserIdentity(user_id)
        if identity.nome then
            identity.name = identity.nome
            identity.firstname = identity.sobrenome
        end

        if identity.name2 then
            identity.firstname = identity.name2
        end

        return identity
    end

    function getUserSource(user_id)
        return vRP.getUserSource(user_id)
    end

    function getUserId(source)
        return vRP.getUserId(source)
    end

    function getUsers()
        --user_id,source
        return vRP.getUsers()
    end

    function getUserMyGroups(user_id)
        return vRP.getUserGroups(user_id)
    end

    function hasGroup(user_id, group)
        return vRP.hasGroup(user_id, group)
    end

    function addUserGroup(user_id, group)
        return vRP.addUserGroup(user_id, group)
    end

    function tryFullPayment(user_id, amount)
        return vRP.tryFullPayment(user_id, amount)
    end

    function giveBankMoney(user_id, amount)
        if user_id and amount and tonumber(amount) then 
            return vRP.giveBankMoney(user_id, amount)
        end
    end

    function getBankMoney(user_id)
        return vRP.getBankMoney(user_id)
    end

    function getItemName(item)
        return vRP.getItemName(item) or item
    end

    function request(source, text, time)
        return vRP.request(source, text, time)
    end

    function removeUserGroup(user_id, group)
        return vRP.removeUserGroup(user_id, group)
    end

    -- REMOVER BLACKLIST
    RegisterCommand('blacklist', function(source,args)
        local user_id = getUserId(source)
        if not user_id then return end

        local ply_id = tonumber(args[1])
        if not ply_id then return end

        if vRP.hasPermission(user_id,"admin.permissao") then
            TriggerClientEvent("Notify", source, "sucesso","Você removeu a blacklist do ID: "..ply_id..".",5000) 
            BLACKLIST:remUser(ply_id)
        end
    end)

    AddEventHandler('vRP:playerSpawn', function(user_id, source)
        TriggerEvent('mirtin_orgs_v2:playerSpawn', user_id, source)
    end)

    AddEventHandler('vRP:playerLeave', function(user_id)
        TriggerEvent('mirtin_orgs_v2:playerLeave', user_id)
    end)
end


--[[ 
    Como Utilizar EXPORT de Guardar / Retirar Item no Bau:
    ( Colocar Esse EXPORT na função de retirar/guardar item de seu inventario)
    
    user_id: user_id, -- ID Do Jogador,
    action: withdraw or deposit, -- Ação que foi feita Retirou/Depositou
    item: item, -- Spawn do item que foi retirado/guardado.
    amount: quantidade, -Five Community- Quantidade do item que foi depositada/retirada

    EXPORT: 
    exports.mirtin_orgs_v2:addLogChest(user_id, action, item, amount)
]]

--[[ 
    Como Utilizar EXPORT De METAS DIARIAS:
    ( Colocar esse EXPORT na função de Guardar Itens no Armazem ou Coletar Itens no Farm )

    user_id: user_id, -- ID Do Jogador,
    item: item, -- Spawn do item que foi guardado/farmado.
    amount: quantidade, -- Quantidade do item que foi guardada/farmada.

    EXPORT: 
    exports.mirtin_orgs_v2:addGoal(user_id, item, amount)
]]