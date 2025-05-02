categorysMessage = {
    ['tip'] = function(data)
        return {
            icon = 'tip',
            title = (data['title'] and data['title'] or nil),
            category = 'DICA',
            message = (data['message'] and data['message'] or ''),
            color = '#37B5F0',
            boxColor = 'radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(55, 181, 240, 0.55) 0%, rgba(55, 181, 240, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #37B5F0 0%, rgba(55, 181, 240, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)',
            background = 'linear-gradient(0deg, rgba(55, 181, 240, 0.35) 0%, rgba(55, 181, 240, 0.35) 100%), linear-gradient(90deg, rgba(0, 0, 0, 0.75) 0%, rgba(0, 0, 0, 0.56) 100%)'
        }
    end,

    ['box'] = function(data)
        return {
            icon = 'box',
            title = (data['title'] and data['title'] or nil),
            category = 'CAIXA',
            message = (data['message'] and data['message'] or ''),
            color = '#2C64BD',
            boxColor = 'radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(44, 100, 189, 0.55) 0%, rgba(44, 100, 189, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #2C64BD 0%, rgba(44, 100, 189, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)',
            background = 'linear-gradient(0deg, rgba(44, 100, 189, 0.35) 0%, rgba(44, 100, 189, 0.35) 100%), linear-gradient(90deg, rgba(0, 0, 0, 0.75) 0%, rgba(0, 0, 0, 0.56) 100%)'
        }
    end,

    ['vip'] = function(data)
        return {
            icon = 'cart',
            title = (data['title'] and data['title'] or nil),
            category = 'COMPRAS',
            message = (data['message'] and data['message'] or ''),
            color = '#E5AE1E',
            boxColor = 'linear-gradient(135deg, #E6AE1E -23.4%, rgba(230, 174, 30, 0.40) 129.13%), rgba(0, 0, 0, 0.60)',
            background = 'linear-gradient(235deg, rgba(230, 174, 30, 0.46) 43.18%, rgba(230, 174, 30, 0.14) 108.06%)'
        }
    end,

    ['relationship'] = function(data)
        return {
            icon = 'ring',
            title = (data['title'] and data['title'] or nil),
            category = 'RELACIONAMENTO',
            message = (data['message'] and data['message'] or ''),
            color = '#F92E3E',
            boxColor = 'radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(249, 46, 62, 0.55) 0%, rgba(249, 46, 62, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #F92E3E 0%, rgba(249, 46, 62, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)',
            background = 'linear-gradient(0deg, rgba(249, 46, 62, 0.35) 0%, rgba(249, 46, 62, 0.35) 100%), linear-gradient(90deg, rgba(0, 0, 0, 0.75) 0%, rgba(0, 0, 0, 0.56) 100%)'
        }
    end,

    ['finishrelationship'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = 'FIM DE NAMORO',
            message = (data['message'] and data['message'] or ''),
            color = "#4D4D4D",
            boxColor = "#fff",
            background = "radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(14, 14, 14, 0.55) 0%, rgba(77, 77, 77, 0.55) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #4D4D4D 0%, #0E0E0E 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)"
        }
    end,

    ['congratulations'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = 'PARABÉNS',
            message = (data['message'] and data['message'] or ''),
            color = "transparent",
            boxColor = "#fff",
            background = "linear-gradient(90deg, rgba(2,0,36,0.8) 0%, rgba(71,9,121,0.7) 37%, rgba(107,6,160,0.8) 54%, rgba(107,44,216,0.5) 81%, rgba(145,0,255,0.5) 100%)"
        }
    end,

    ['staff'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = 'STAFF',
            message = (data['message'] and data['message'] or ''),
            color = "#4DBD60",
            boxColor = "radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(77, 189, 96, 0.55) 0%, rgba(77, 189, 96, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #4DBD60 0%, rgba(77, 189, 96, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)",
            background = 'linear-gradient(0deg, rgba(77, 189, 96, 0.35) 0%, rgba(77, 189, 96, 0.35) 100%), linear-gradient(90deg, rgba(0, 0, 0, 0.75) 0%, rgba(0, 0, 0, 0.56) 100%)'
        }
    end,

    ['ilegal'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = 'ILEGAL',
            message = (data['message'] and data['message'] or ''),
            color = "#DDD",
            boxColor = "radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(221, 221, 221, 0.35) 0%, rgba(221, 221, 221, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, rgba(221, 221, 221, 0.80) 0%, rgba(221, 221, 221, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)",
            background = 'linear-gradient(90deg, rgba(0, 0, 0, 0.60) 0%, rgba(0, 0, 0, 0.45) 100%)'
        }
    end,

    ['911'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = '911',
            message = (data['message'] and data['message'] or ''),
            color = "#2E43E6",
            boxColor = "radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(46, 67, 230, 0.55) 0%, rgba(46, 67, 230, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #2E43E6 0%, rgba(46, 67, 230, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)",
            background = 'linear-gradient(0deg, rgba(46, 67, 230, 0.35) 0%, rgba(46, 67, 230, 0.35) 100%), linear-gradient(90deg, rgba(0, 0, 0, 0.75) 0%, rgba(0, 0, 0, 0.56) 100%)'
        }
    end,

    ['store'] = function(data)
        return {
            icon = 'cart',
            title = (data['title'] and data['title'] or nil),
            category = 'LOJA',
            message = (data['message'] and data['message'] or ''),
            color = "#FCB315",
            boxColor = "linear-gradient(141deg, #FCB315 -66.94%, #5D00C0 100%), rgba(0, 0, 0, 0.60)",
            background = 'linear-gradient(150deg, rgba(252, 179, 21, 0.32) -48.01%, rgba(93, 0, 192, 0.80) 100%), linear-gradient(90deg, rgba(17, 17, 17, 0.90) 0%, rgba(11, 11, 11, 0.85) 100%)'
        }
    end,

    ['pd'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = 'PD',
            message = (data['message'] and data['message'] or ''),
            color = "#1DBAE5",
            boxColor = "radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(29, 186, 229, 0.55) 0%, rgba(29, 186, 229, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #1DBAE5 0%, rgba(29, 186, 229, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)",
            background = 'linear-gradient(0deg, rgba(29, 186, 229, 0.35) 0%, rgba(29, 186, 229, 0.35) 100%), linear-gradient(90deg, rgba(0, 0, 0, 0.75) 0%, rgba(0, 0, 0, 0.56) 100%)'
        }
    end,

    ['default'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = 'CHAT',
            message = (data['message'] and data['message'] or ''),
            color = "#E51717",
            boxColor = "linear-gradient(135deg, #E51717 -23.4%, rgba(229, 23, 23, 0.40) 129.13%)",
            background = 'linear-gradient(90deg, rgba(0, 0, 0, 0.50) 0%, rgba(0, 0, 0, 0.43) 100%)'
        }
    end,
    
    ['event'] = function(data)
        return {
            icon = nil,
            title = (data['title'] and data['title'] or nil),
            category = 'EVENTO',
            message = (data['message'] and data['message'] or ''),
            color = "#2E43E6",
            boxColor = "radial-gradient(85.48% 409.68% at 96.01% -15.75%, rgba(46, 67, 230, 0.55) 0%, rgba(46, 67, 230, 0.00) 100%), radial-gradient(604.06% 271.23% at 1.29% -10.27%, #2E43E6 0%, rgba(46, 67, 230, 0.00) 100%), linear-gradient(158deg, #0E0E0E 14.84%, rgba(14, 14, 14, 0.00) 166.28%)",
            background = 'linear-gradient(0deg, rgba(46, 67, 230, 0.35) 0%, rgba(46, 67, 230, 0.35) 100%), linear-gradient(90deg, rgba(0, 0, 0, 0.75) 0%, rgba(0, 0, 0, 0.56) 100%)'
        }
    end,
}
