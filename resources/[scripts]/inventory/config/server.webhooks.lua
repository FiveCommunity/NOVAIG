Webhook = setmetatable({
    config = {
        chests = {
            ['Deboxe'] = 'https://discord.com/api/webhooks/1340976496478650439/LXuAK1fNGbPPW8ae0Co9OhadJmWhMi3SGLHkfnqrz9hXb2JBm5aMvGqk_8lAvi03h5sC',
            ['Policia'] = 'https://discord.com/api/webhooks/1339687619272904776/_mAKHORfKUhpp2Ko94CSIr8zqos2dv65NSpoSV1ILexqYPJhVRrzAZKzasiIRvPtyq_G',
            ['Core'] = 'https://discord.com/api/webhooks/1339687522007253157/p4Z_tgZawvnr9RleZAveyo4hA0vG_wcqyloJOvt3jg0H0_XFrp6oBMAXC7vEjOMVSR_w',
            ['PoliciaCivil'] = 'https://discord.com/api/webhooks/1339687394110210229/XlQNFIRw1ZgoMh4ky0qYaqXLmynRxGoesmkonAV6_UeTZk-_643Mm-gdT4eDM7BX7CUN',
            ['Bope'] = 'https://discord.com/api/webhooks/1339687724046618695/bu3acL9euuN_DkeMr6Zcn8848I0qkgnVb-yXcOnIudEwpZFtZoGjUucByn8vfE2l1vHi',
            ['Choque'] = 'https://discord.com/api/webhooks/1339691299153903718/PW3YYHGKfY17XcMFnq52XkqicGOCG1jX2hL5vNFKTksKyzn2qzP8F8EpF48vq9HO9qr3',
            ['Federal'] = 'https://discord.com/api/webhooks/1339687187523960842/VtmZ4OaZ7HHGgWfalZ4ErP7Q3MHqq7AfPxAk6zPSSS1O8gWe8wGpamvC6MmVK-BANXvd',
            ['Cot'] = 'https://discord.com/api/webhooks/1339687302749884446/tmCrSRMm6WdcO42fRak9G-bVgX0rdztlaT4SUBM4eOAgNIwvqYXfvltk-zsATZKKjAYi',
            ['Prf'] = 'https://discord.com/api/webhooks/1339691447632396362/phTdJ_J7C7vyhcYczXpZBF_GGW2BmxZYClYL55Ku8eRJsJTQPe0S6yAhPNCZr93YaMMe',
            ['Exercito'] = 'https://discord.com/api/webhooks/1339691539764482078/7vF6Borpjh6-_jJB9o0e4dn-KS5IP9AsjpaTGSPVYdRuiWcTuQBnDOcsvudjpS--JYlx',
            ['Hospital'] = 'https://discord.com/api/webhooks/1340976369219141693/H9dBNAaVJ0DtKoZuO-0R40efqsK5-uvVTEAVHMqc-BHO0rsvvMKP75ENlaqoLi60Uvk8',
            ['Sickomotors'] = 'https://discord.com/api/webhooks/1340976559154270249/RaAFGY7y5nEUNPIO6ohqHsF8TyvK8PsKnx2bOoKvsEiCtu_D28J0PE-w5FyFWZaIU_sR',
            ['Premium'] = 'https://discord.com/api/webhooks/1340976625424007229/MbvHka5mEQJEn8JvRMQ-vCGMaIbH7l-hvv0OLFMG_Ddo87Nw0-MIRIiW2Dl_JxQwJ4U_',
            ['Redline'] = 'https://discord.com/api/webhooks/1340976686816169994/mTxCoF9hUtjx1bHmGeDWcYXH-UTwg_8kVIi1xbgqDS3fRRKmUNKVuJTqK179mkLTnpMH',
            ['Sto'] = 'https://discord.com/api/webhooks/1340976829733015572/usXld08OokyT8peX_8R9KV02cfh35NVtYGpzaUI02X3UeQuTFIvpRxnKHcRHRpljygpr',
            ['Jornal'] = 'https://discord.com/api/webhooks/1340976879091580949/9oO3zCGjd8W5ehUJ2vRE1yztFpctPg5D1rTff3854vcFFubstewX01BPXB-44HtKU7g5',
            ['BombeiroCivil'] = 'https://discord.com/api/webhooks/1340976932480880810/CrLh4_FZmjIzvkT8tBhkQZDG6wffW-wQP8Hv3K0kWBJipMYQl9O26V6HBUlTiUYjEtID',
            ['Bombeiro'] = 'https://discord.com/api/webhooks/1340977001271525457/gpLGGfdbzGmTELjJKuvYpKzqIrpg1qC3jPRfGv-YjqaviZ0rj7MYFXg5gkETjGChgYyd',
            ['Judiciario'] = 'https://discord.com/api/webhooks/1340977061820633128/qMAYOT5dr5U1uw4y8cSP6cBtL2vfNEJPRCufJmjTXPBZQDoeILSzcf7_3CEm1mLNGE5n',

            -- Armas
            ['Hospicio'] = 'https://discord.com/api/webhooks/1315113995828592671/O_WD5vGjZ4dHmoL9CZr_0bGGiyINiNjzkTCPtthLgK9AUukNX6YGQrx3-G-eU9Mixplp',
            ['Lider-Hospicio'] = 'https://discord.com/api/webhooks/1317192950635036702/RALF1jz5g_OVDYGteRX97D-jMQzA0xPvPSQiAXHQRM8b3ur7hGp9ZKkBMnGh1K7FTDNi',
            ['Inglaterra'] = 'https://discord.com/api/webhooks/1315114114410090506/FIRxTu_qXmbhpcZcBk_GVr_-ZxHvkzv7UY7-snIPGdqVMGSL0WWHTEjt2GZVkzdSD3rf',
            ['Gerente-Inglaterra'] = 'https://discord.com/api/webhooks/1320077287189774458/bETneBye5vuCxnqfZ5h4SIxUlF2P4SNoWzvDlRQt5A5sb_OIRFwnZgBIHdvHI8htK4ko',
            ['Lider-Inglaterra'] = 'https://discord.com/api/webhooks/1320077252326854737/uUDoJqOJnvdL68kBQq8PDtEu6O-XGF1jtpUKYGVzdOttIpJbtMq7LHeRtvB_GH3niR4n',
            ['Cv'] = 'https://discord.com/api/webhooks/1315115328132616245/Z5YO73XS6k-1-kR7N32kR6VVp5oH23a_3Ga4mTjzPLPOEQDpHU5obOUd0k1hRPPtwX-e',
            ['Vaticano'] = 'https://discord.com/api/webhooks/1315115442859409518/imT_G8VavXOz9f6VAliVAB0bqWVyE8qGvk4fcLrL8phIp2IBr35atfjQBU71ClyPnAIA',
            ['Gerente-Vaticano'] = 'https://discord.com/api/webhooks/1317188912665591808/9PJ7KMFz90zp_XwBJcEP1TsWSKv4Und9turkQs0e35jw-7ChZIV7zzDLsuKu20i54PB6',
            ['Lider-Vaticano'] = 'https://discord.com/api/webhooks/1317188944756084796/9ycN-Uze-TTnAy0Lr7i30ttSd8cZV1VZQO_XBQOxpViK5lmuF1SmOiT52PJtqPIEetf7',
            ['Grota'] = 'https://discord.com/api/webhooks/1315115553446170735/F3Wb_KZpYhgss2mFubUeCOPCLI-vJqSZ8Dm2nvt6miH0GmsV90vQrmx8YGh3enITFnWX',
            ['Lider-Grota'] = 'https://discord.com/api/webhooks/1317189759713677382/Gluy6kKO8rjGJSqPCd28wYC145xfgAe4g0bcZpyRgTq2BETa0ePgNZBvZYcSlZSBzd1Z',
            ['Magnatas'] = 'https://discord.com/api/webhooks/1315115659243294740/RiaQn65oJnipSJ4J8U6Sobf794NcbsA1G20KtpPp09xxRUmPwS8B-jD8FGmOJgVMPijN',
            ['Gerente-Magnatas'] = 'https://discord.com/api/webhooks/1317188595802701885/O08g2xjPxcWGyIyiTo-uqhWEVNduz_CR5X3XRLyD0YOvKjtXcWZz_xVE0npinvNtEKEZ',
            ['Lider-Magnatas'] = 'https://discord.com/api/webhooks/1317188645467328512/ZJEFHjMnknfUnAfXJqozGFkCu4WwhczfGyokqy70A4Bmxl7fBEGVF6_VHa3_AglTpXHd',
            ['Lider-Magnatas2'] = 'https://discord.com/api/webhooks/1317188705928085524/zdIwLZQ_EXKQ76qo4dWhsN6i-zs_k79NBq0EReD_EkmkE6eNHpABdC74Y5MfQ55sEceJ',
            ['Milicia'] = 'https://discord.com/api/webhooks/1315115801338052750/-nwLRQzg1iXsdhGM3ehKlHiOdwFGY7Aeo26GF2w9BV4eYWCuKcrzbA12bW83y43U1Q86',
            ['Mafia'] = 'https://discord.com/api/webhooks/1315116045119258635/CzLChnUTnMPwJn8zM2IiE1tLG2RWAPDm-e1hWdyqCybwh83_-K36DBmvj4424drO9bFA',
            ['Lider-Mafia'] = 'https://discord.com/api/webhooks/1317190130481500170/3InKx_OL6PSR_Pj4yWO-FLkEvskAc2HD0uA4b-KyGnNodNWXVxkyzruMTKfjU7AEbBXp',
            ['Corleone'] = 'https://discord.com/api/webhooks/1315116163612807200/kWTHavBvq1PCGSFvBER23E3LlrWBXnG7Go9yZ6R5L_EcFE6bkcok-jWZpBU3Srp6agEi',
            ['Gerente-Corleone'] = 'https://discord.com/api/webhooks/1323091189792243743/do_q0PQmqWNmgsquN6uFq3PKbIneewL3tUSEuntpAVmAHonVlH-izU6wm8lDC4f1m7mK',
            ['Lider-Corleone'] = 'https://discord.com/api/webhooks/1317189596458520678/rVYMUCupw3clzOunNVkjXMYIkVq4z28rJ6VRyrNEl2eQpHTjpHPm7049kELpgMUmOLKc',

            -- Municao
            ['Okayda'] = 'https://discord.com/api/webhooks/1315115617682198620/bMCZkiG7xmkizg0_QT8oDgCNIgrVXBKkK5B_p6yoYnRYnJjdgGeF3oJFdaRo5wgh9uhx',
            ['Gerente-Okayda'] = 'https://discord.com/api/webhooks/1326388534977888288/UBKT8klLraHTrcpcS0s3ljIZ8cc3O4n0Ss7IwiK6sBpPzJFjR_DOFTuWYRs3JPEteajL',
            ['Lider-Okayda'] = 'https://discord.com/api/webhooks/1317190960882516070/SDIFcm0NZRLJWJ8N0K0kF8P7gBxmdQMV9foagHMAFPZm1Geyt2CavLwhYwPCAiOTxh6t',
            ['Lider-Okayda2'] = 'https://discord.com/api/webhooks/1326388462945046618/LFgduG9W9hF9Lojc5XJBFtrKaag_ZFKpqn5OEEyzSQm0jbjrlcIH9CEzRNnfkmqiDg30',
            ['Korea'] = 'https://discord.com/api/webhooks/1315116003277017179/hiyFdgEpV_4h38hVg0fXuelFIjr0gogpWKa1efVWc63brkVNFLPxHUnS30_IIZYcJ2Nf',
            ['Lider-Korea'] = 'https://discord.com/api/webhooks/1317192852962410526/-1Z-xoL9I70oWX8OjlQSvld7bwQpHLSeluYq4sagq9dNyGqJtKVZd0bgrWrbxrzFLn0N',
            ['Egito'] = 'https://discord.com/api/webhooks/1316410823240847450/oZ-fEmyMhjT_piqODRMquEAmkehWsR8R6C_cheI1n4MVAaUzxMFdWC9CqIhQ7FCbnBkP',
            ['Colombia'] = 'https://discord.com/api/webhooks/1315116157170094112/-payTCSigKvcpB-2-8hJfc5LVN7ftNlpIuonUNKQuh06wu_mh6XIq2gY0jTLjnrT56r1',
            ['Gerente-Colombia'] = 'https://discord.com/api/webhooks/1326388200679276565/I9bFsSxot7WrkF2s090UVYtZRvf8b6pYgomdIHNoXANIDp9vYEJGkwU9cfx1E5cqEMIk',
            ['Lider-Colombia'] = 'https://discord.com/api/webhooks/1320109243658932325/jzZKUY-IL1kSMySXwJb_TBgHKn0idEfZ7O3FMRJGQPu1RjinRA2SQRGyR8LGA0jKcl7z',
            ['Franca'] = 'https://discord.com/api/webhooks/1315116262044467250/0yyn2uRAcZBOIm9t9NUHTkoUAwBD3UEf4RF7OWgsr_PNZLGAp364Vg-juZEhorDdx0CR',
            ['Lider-Franca'] = 'https://discord.com/api/webhooks/1317189876109545583/D-0vhVgDBkHhY9yR6kE9CrTB7zGbKkpq0HmsbBfCi1Nm8F9ph346SIVgxj8dY27HVyf3',
            ['Mexico'] = 'https://discord.com/api/webhooks/1316411078367907920/dfCrjIIScp3LZYTXZqiQMfIuSW7a6K00u5HXeU9eu1pTDGar8WZ5MAX4vdC05Ye9plDF',
            ['Gerente-Mexico'] = 'https://discord.com/api/webhooks/1323091067121434695/hcsVmwHjIef-sz5M9yWQu9VrSSnSHeO3O7cWBOiH1NnbM1Hg_hoiA9GduOWGEikpAusV',
            ['Lider-Mexico'] = 'https://discord.com/api/webhooks/1317193670885117962/aYI6fGj-Y2VaLSZx6sjx2YN-j8i61Z9zUyHSLdyFMrNaM6dCk91tkZdRArL433IXrIEK',
            ['Yakuza'] = 'https://discord.com/api/webhooks/1315116370257645681/zcFAt7CjH0E2VcgVaeMlVvQFVTLVB-cKR4YfDQus6l3kD6wZZmbwcjk5JdrkYYdxmR0Q',
            ['Gerente-Yakuza'] = 'https://discord.com/api/webhooks/1320116196607004833/YZjMXYzvhTY5lpT2APO26bu0UDac3jyztF3JPsw0v1C4SDMZmWnxwgvXZMZSP45QSqwb',
            ['Lider-Yakuza'] = 'https://discord.com/api/webhooks/1323090018260222073/Kt0GCJgdOHtyha-SuAtwc1wgZaILH3rqKUItS-t_26i5E-aUyKqu0uFlTOofDCHxlVpu',
            ['Pcc'] = 'https://discord.com/api/webhooks/1315116411538112532/9tApSLSRWVl6PK-Hrohc-T-oZWyYTmcBoj4bHDTMLqG7GR_hM_aVKWGqYht9L5PuaXTt',
            ['Gerente-Pcc'] = 'https://discord.com/api/webhooks/1317190309205245952/sqM8w4UqN2raONOXHcLj8MJ2r_U78fHYYZmssyXCHMXwnQVHEz0ENEnYV9suiyjhuOUB',
            ['Lider-Pcc'] = 'https://discord.com/api/webhooks/1317190350871334993/bbmL-Pc0VXbeFWcz1_G-U7MKgBygxrFnrCA5dIC_Dppo3kjfuunoXFWQBrhC8PmIhxsn',
            ['Bratva'] = 'https://discord.com/api/webhooks/1315116451467886632/VwYAZdBJGyr8HCgdnPa6Y1GDkWZGU3gBCVAFopkWGtuLguLSez7j8rmaIWb2tuXv3PdA',
            ['Medellin'] = 'https://discord.com/api/webhooks/1316410992988524554/DS6ol7XEk4dmLABPKa839zqAEmOE7tu6_0cZvjAxu_Sq9hkRFiUGd5dGbccRC7CtwE1r',
            ['Lider-Medellin'] = 'https://discord.com/api/webhooks/1317189995433300038/NIPNTPtRv4aJkUORiRPHkohngUYPhD5tBxvqYySdz-4eoZpFTw6N-TRJXKvhdTpnxbi8',

            -- Lavagem
            ['Bahamas'] = 'https://discord.com/api/webhooks/1315127839422414909/sx2lwfJqmFH8HICzuS7-MO_rjck7ar-hs2VkicGk88gbNboZbutweO8Nwz5zXfkjs8R4',
            ['Gerente-Bahamas'] = 'https://discord.com/api/webhooks/1317193143946449016/0ZLstmTzsIIHg17IGY1b75iDAlrtp1qYOr0W6nEHzB1UtoUweMQ_kpBmBHDIJ9aPxN6A',
            ['Lider-Bahamas'] = 'https://discord.com/api/webhooks/1317193197533003866/4Bi81kiLwGqnBRd4xZUn8Ju8aL1KqwLYqg5b5kuk87VivvCpYClWrxgY0NksHRXY88u-',
            ['Cassino'] = 'https://discord.com/api/webhooks/1315129248272355450/1a2alNC-pT2b45B0Eb5OHCum6LTxeROEcsfI2rkvjkmH50KyIkXp8JNpI-OBhG5-N5Aq',
            ['Lider-Cassino'] = 'https://discord.com/api/webhooks/1317193049348243456/yVJJyyZptYwJDKbG31tFPifFdwcxY0xHIlIM659Dotw7Pad6WHiZv1x4eNrYYBu16o0H',
            ['Sete'] = 'https://discord.com/api/webhooks/1315129370582712371/X2sQWZ1JaJ1LHPH3g7qkbiFsJ_U5h_1SUvm8n4-XWF_NHA9mMnCtHFZA4DxuKgqFQAI4',
            ['Anubis'] = 'https://discord.com/api/webhooks/1315129490787012638/dzTMKi5LY9ygNmm3JU1yhcfxeqG6R8MxXXd7p9OTrMC9UlYKCH3IeUrGkhle_D7dZATh',
            ['Lider-Anubis'] = 'https://discord.com/api/webhooks/1334933273931026554/URX2oUkkuIiwM-BOxloUHjBO0l7afzlNuAISBlkOVSMet1pWF_4Q1FwKQW4xsyAsJWyA',
            ['Anonymous'] = 'https://discord.com/api/webhooks/1315129587004604416/gC_ERTlggQi57dV_Rt9Iaa0tURBq-sNpI0s7ltL0lFMP57hBi-4h-Ix8ZaU-QbmJq8Vr',
            ['Gerente-Anonymous'] = 'https://discord.com/api/webhooks/1342311242756390942/G32ZsEUKYOs8yPtjGuy8oinghwPj1eUjtOBPB-Neg7oiJnkMbkQ9a4UAtYNJFieYRG4M',
            ['Lider-Anonymous'] = 'https://discord.com/api/webhooks/1326586514385404019/KdFZM_y5iqoTYqTButnRkswe7hI7znnn7F3I_NDy3x_cx56iln6J2J1SAUPETco4ZUSa',
            ['Lux'] = 'https://discord.com/api/webhooks/1315129683167154236/T8FAXaph2VF2nd2AURcAeuPhTc21zO-D2s4F_B2ACe9mjgKPoHPtnrCDTEt5AjRxgSof',
            ['Lider-Lux'] = 'https://discord.com/api/webhooks/1327786666911334400/i_azl6AWf_Eyp8JTOIiqdCg9-PbacwGpmY_HqEtKTGYtERi53p2BnTxZ6_7pu2Bt2S_D',
            ['Tequila'] = 'https://discord.com/api/webhooks/1315129779183292488/0NmCOW_WZIGwwc29Q1ViFyr-xi0LsZcVO_wP6TKCLM9TjXvI7YADC-Fqj2HLIIi776M5',

            -- Desmanche
            ['Cohab'] = 'https://discord.com/api/webhooks/1315115917604294727/78M0BZBKHykQ1ZTJX7Pe8hifqONWbQjxunKxgfZnvB0YTZHhwqh4dJMh2cU2izvwfnix',
            ['Lider-Cohab'] = 'https://discord.com/api/webhooks/1317193936229367932/tQJLzrP2Qrkd_b8uRvOqLjrUIT2vc8cdPw7YYEJ4sbu4_0gAhReC5EY9FiFbsELIztOU',
            ['Cdd'] = 'https://discord.com/api/webhooks/1315116210777755719/FfOnZrZEiUvCEV1ZyUY9xW75AgVxS-17LtI2lmvxDnyhSWT7Jy_6yUSUmcCghlUHvlcU',
            ['Lider-Cdd'] = 'https://discord.com/api/webhooks/1324137469557608579/ZhBe1YDbWjBXcwcHBXXKEBkFFVT5sQK6NmdtAlf8-Dj5_BIKh9eHDd_obL8tiUL3n1Ea',
            ['Motoclube'] = 'https://discord.com/api/webhooks/1316411460532047913/Vw5SMHaQR7kky1T_AdAJu572BC87xrE2RODIK4LHyhwlBKsiwju7y-PfGDgLxd7Gvft9',
            ['Gerente-Motoclube'] = 'https://discord.com/api/webhooks/1317193299697602580/mmZ4F6A3veZeBVOa0jsCU5nuV0fgVPFzN3jEU2LXGRmAl9GoGeFTEcyzkXgg64eiGfMt',
            ['Lider-Motoclube'] = 'https://discord.com/api/webhooks/1317193362175955005/JC3l5hoCCnLBhVub3OtHI6tTxwEXfbvq6HrRncmml6HAKurj_8LLQQxLQ5Odhy_DkPu3',
            ['Lacoste'] = 'https://discord.com/api/webhooks/1315116626323968061/id85x1DAMI-alUxb6P-2A0DfQcDSgcNOaRAesFHD0dx9wBWCVN1cK_Lw_jyRN6ynoxYR',
            ['Gerente-Lacoste'] = 'https://discord.com/api/webhooks/1317190591943278593/yKaRiK48bNmv5VUUNmsYdOnw7lV9hMp59U2fjLGwRtwyALzgYBdFRZGFL6JI8OV0FbIj',
            ['Lider-Lacoste'] = 'https://discord.com/api/webhooks/1317190636851429418/n4PPD9WBYn4Dt4NyrtLOoGRYOUc_U_xzIO5FkI2HzoNwEC1nzKPns6LgGX153sVrdDOq',
            ['Bennys'] = 'https://discord.com/api/webhooks/1315117745158754314/gOUTQPdIznUQFy2aGAU_hNWlN4WUL7aQs76aVUD0gETrz6pW6U1i3tpC4aPi1Dldxhtx',
            ['Gerente-Bennys'] = 'https://discord.com/api/webhooks/1319413926986907728/UfwVzU0O4XqjVMM3jxvG8iewEfUGw0sQ31WoOF-f73WoJR7aVs-8rvi28aucOD-esySq',
            ['Lider-Bennys'] = 'https://discord.com/api/webhooks/1317190455322218556/4utfmOTpFyH0Z5gvBtkKpO6_WcWfqcwmz13cKhQRzHwteMjbe0iMsZWdguwl8vI3mFLB',
            ['Roxos'] = 'https://discord.com/api/webhooks/1315118349084004352/1bPcGolz83J1F121UMeMZfftHWWKtJgTamZzIxBjJbjt4ZZPUPwUZVPDPSgUQAOT1-Nc',
            ['Lider-Roxos'] = 'https://discord.com/api/webhooks/1332879146505867316/f106VM3uOMG-_O_5IzEYEItqtAXvJiwqqQtUCIQyCHXUxiQKTwsYHMZKFhH_r4uG8ee6',
            ['Heelsanjos'] = 'https://discord.com/api/webhooks/1315119590103056425/iqdsH-KnbpuSTWIka_K7FYEdkQeEjRWsOvUAUTlKyuvvp0xdHCa-qF4L8qm8PLzksLr9',
            ['Escocia'] = 'https://discord.com/api/webhooks/1315121102598443089/shfcyRKH3fedQ6k6h0D4rIjaW7wN1xSKUucmUHH5uApjVbUcPTzja-sHwBC97n_2mBCL',
            ['Lider-Escocia'] = 'https://discord.com/api/webhooks/1323089300669071402/icBlwMolPZ3yhtCVblF3kv52Yl2vX9eHbgNcEyVYCSidWmw1CUtDcYhaL174bz6JY3Mt',
            ['Hellsangels'] = 'https://discord.com/api/webhooks/1336743535931560057/tLm1FpFkdXI9sf2Rrtzy-I2JsDEfoHlusyKyPsMToCrlVpvICXjW1Ev61NINwxBzm0Y7',

            -- Drogas
            ['Elements'] = 'https://discord.com/api/webhooks/1317191323370913834/SeddAyvUAKE9NfCzDtKO-2mVJz7HMiQ44GVvJGO3LBWgB0RRGwI5BmxsxxFZ1hxxOWPg',
            ['Gerente-Elements'] = 'https://discord.com/api/webhooks/1317191128214274048/LV5Nlsqglrxn27X5eBJYlH2z8mGv2hpx_vVZQD4NMSPO56FjZBp7rcA7srR8TnazfE-3',
            ['Gerente-Elements2'] = 'https://discordapp.com/api/webhooks/1324432206839681165/b67Xxw2IxVWYsgH_hltmhX73tKwhX3l9uSJMcnTSA9re_uTESbI7Lficgxss0KXPj1DZ',
            ['Lider-Elements2'] = 'https://discordapp.com/api/webhooks/1324432275042992223/zko24pl4AFecP7xRy0jS1jLpUwekXo8WHQF-dGciJdA1I6ajMPXxS6SP9tzrPm169KR3',
            ['Sindicato'] = 'https://discord.com/api/webhooks/1316411329011253248/dDwUcLbDePGgNXaNv-KQTmocuFEyvlAkPI9dspEaDnqPFzTvassDtUr5gWqQcpw4Uu1f',
            ['Gerente-Sindicato'] = 'https://discord.com/api/webhooks/1320850299090632714/par7kc-d_K9P0Cj6Eb5G2soEjFVUaqWsuPGCRGpDJD1wwU4drp0J4XKd99BC_85qMeZR',
            ['Gerente-Sindicato2'] = 'https://discord.com/api/webhooks/1320850544759410771/IVjxXBGlnJ0-MocKM2I3ayr11hYwqbG0IJKT7ZMBZy_6lkfGXSeM7IaMYv_su1wlMSaa',
            ['Lider-Sindicato'] = 'https://discord.com/api/webhooks/1320850704809721897/bhRzVY2m93c4oN3G4ht6Md24AC2AAiU4ANx5C6ie4RjQMb04A-L_3BD_4F2mvEFhxc2P',
            ['Russia'] = 'https://discord.com/api/webhooks/1315116009958674492/BGVTcqa3QEi81-g8eWPdRKRk-UQ2OtHcyY-1zbHSscGPW8vrhaAiPLOo1bZp-9UK7KL-',
            ['Gerente-Russia'] = 'https://discord.com/api/webhooks/1340480940006314004/B8ko8RYuCdJO0lVU_sGIU3nIvoHM26doVOvYq_qQ37mvQuOAw7pwECrQ5nKgyAotrgw5',
            ['Gerente-Russia2'] = 'https://discord.com/api/webhooks/1340481304113971200/57oWLSpUx8xy0zLEugOB6a5-e8qnVi81yaVkTSCTwnkAVvpWkx_EcAhNPUmhVxhDl7F-',
            ['Gerente-Russia3'] = 'https://discord.com/api/webhooks/1339769150880481294/ZYb7dg5xFmKoEpF6ly18mvfSyUE4HbLXiopbcJjlWlQLTJrFpnVorKgDGUyTGKq1bBXW',
            ['Lider-Russia'] = 'https://discord.com/api/webhooks/1317194436081483846/628_wOElr1wdpggon3bwW1sBOf9RVW2vVItkAtYfA8Y_0HEMKC8qSQEHiz-tbTSkiQmq',
            ['Lider-Russia4'] = 'https://discord.com/api/webhooks/1340481855547248762/IbctoW9Onc3fnLluGAIFc5v5hgDR-KNWRLoWEhH3ahxXmhIp9glQUI4Bk44BwhdVlkek',
            ['Lider-Russia5'] = 'https://discord.com/api/webhooks/1340482095126020177/cyZ0qqciEKLmWbscAqNH1Us_WidKjdclQwCyRdz2mj6fhnPuSCIUL7cdPbRQpVL4U5uQ',
            ['China'] = 'https://discord.com/api/webhooks/1315116095606095892/ZfJ9ijoUy-y2l7igFHC2UxE69Lqk76OqBhc_4MB3SjGKChiq3-mLpVRRIIDyM1hGlJM8',
            ['Lider-China'] = 'https://discord.com/api/webhooks/1343666773748355225/-crvNsJSBabuO8uSXLNYs27g7LjQUF1589LY-YVEDUkhAL6AWw6U5yKJMRoF5t63mML8',
            ['Lider-China2'] = 'https://discord.com/api/webhooks/1339671552534249482/TPdBcm5V4ytrc7JvUyjo9SZmUVcypzIX2vrpqg55_-2gw5T0EzUDvyjippTZcei3rDw0',
            ['Grecia'] = 'https://discord.com/api/webhooks/1315116269602738258/3q8NK9y0Q_ccIY1f8Sa1tCQLXegpzG1QScDfHsaO1pP-_aB_j_O2itMoUHX7IeF6OZ47',
            ['Gerente-Grecia'] = 'https://discord.com/api/webhooks/1323090152209518622/f8_8SXzWc-oHtniULfKWRpsvXgi2BuBgk1O8BISUe6aUkmL3JMEI2XyJSeOD1QS8WUPZ',
            ['Lider-Grecia'] = 'https://discord.com/api/webhooks/1317194616037965834/MDCHxCAyStduCjPCRccNrgNA7BgFkbQdNXU8tXdGMCOUHNDX0Fjj_uSVwuJsZtztHSGp',
            ['Irlanda'] = 'https://discord.com/api/webhooks/1315116367313240175/RFoHhP9Ubt-3cGiPRyLgAE864UUuBLh_4NYvZmfwvbZ43fyRKusWil7dUd8G_oXgYywd',
            ['Irlanda2'] = 'https://discord.com/api/webhooks/1342218600022282400/jQO_r-oEHv1GKLubnlOC2XtepZePKgt7cJNN-W6wi9B-Q-AkaaWqyNClr0SehUZzhBnB',
            ['Gerente-Irlanda'] = 'https://discord.com/api/webhooks/1342218711892885647/RdJ0X6rbTMgOSI6cB--w9ciY6CGWsFzJhgn8Buw6FJWNu9zC0-KJmH8-nLITCUhq2UcW',
            ['Lider-Irlanda'] = 'https://discord.com/api/webhooks/1326387976099463199/s5tgWuHhl0K0xKFaYbJF9pCV_G8Md5uiTV1rrUyrfVYbD7upJXf7iXMfQE3qrEni22U2',
            ['Taliba'] = 'https://discord.com/api/webhooks/1315116450960113727/7ZkTm1wyMRaHIySUUllqu7to7O0B8Iw0_a5mz2UbhA000BR1VA_RstIEcBeHi8so3QXh',
            ['Gerente-Taliba'] = 'https://discord.com/api/webhooks/1317194112071635076/wJ-TvlB8Gmzd2ottG6A4qb3Mdev3GDr83_4mIwklTapdDtjjZ4gj3pyl_kJg9kfyQzo1',
            ['Lider-Taliba'] = 'https://discord.com/api/webhooks/1317194048204705843/lhEkYjZRDy-95QjPOlp95EryRCU2NDJA5N4iDw1qnljNgfb651bJhTRbKl55rY1CFY9L',
            ['Medusa'] = 'https://discord.com/api/webhooks/1315116563757793420/kH_uOl31Fim3WzFR36QRyqh2gyJK0oXk12fYHEx5tvE3W-nro7Iz_6cmDbIKSkVHV_Fe',
            ['Gerente-Medusa'] = 'https://discord.com/api/webhooks/1317189282732965959/VSaFV_1cSCa0dTrnjMfeinI1LFncDxJz6QRCiFiLp-WLFMyfBMUYpWFI2YuoN9ht0JCw',
            ['Gerente-Medusa2'] = 'https://discord.com/api/webhooks/1327373168490315776/5FNzug1l40A6YiMrfRJJ37nBLS9qFDss8aqjHgrA6iiW3-ssqgoeAmcEr2n__9yD_vJm',
            ['Lider-Medusa'] = 'https://discord.com/api/webhooks/1317189332481609801/8-aVpD_xJtXIFl4VDNSWxKMBq9N8dXli5RDgr2C4x8ljlR1l3Ww_qnMeXslP_Fs4GiBS',
            ['Lider-Medusa2'] = 'https://discord.com/api/webhooks/1327373391384150067/IZ_f2MGf2BnzgqYAv_sH1HWdAXIF3Qh7pmZwj2Jz4hXTGE3ly3eWNiRXefzJC0PP4dbJ',
            ['Lider-Medusa3'] = 'https://discord.com/api/webhooks/1336728480762826782/K50EAB-gyj19ZwFaQkN-uglgsV_kiMv-iuNWUbHbGme4pgP6eflnVv1xuiVfxkW3BlDC',
            ['Abutres'] = 'https://discord.com/api/webhooks/1315116617138704484/IFbzjWOGKjODt3VRgo3h7NvYuDuaXaFXC9ie1K8dwr-S3e0G7Ig-CmjIFve0VJT7KcfX',
            ['Lider-Abutres'] = 'https://discord.com/api/webhooks/1317190770490605608/uJ7QZSgqEJj6RapOwlkle1_lI-HST_csoiwBl9g_jcdlGKgYOj1RK65jgr6YnuUzUXdc',
            ['Italia'] = 'https://discord.com/api/webhooks/1315116710331813949/lez1bDAlppEIAmQ0xQVmrCywzc5fvnE79Xqq1mKSdqL__20o2__KwVEtxhWSNnTsy0gR',
            ['Gerente-Italia'] = 'https://discord.com/api/webhooks/1323090739198038119/2xy3fJ3BgMHFeGgvHC9zgkrB8vN3-Il8i3OHMQtm4o9NV9Bc4TLiEbwJzwsXqALgirj1',
            ['Lider-Italia'] = 'https://discord.com/api/webhooks/1317193534511517700/kXoieycKVeXo84t0w-EGKSb8xZ8CfiJlDpXOe-rwLhxP7CVl2wiZQLrV5e1EqZR9qaTk',
            ['Lider-Italia2'] = 'https://discord.com/api/webhooks/1323090608134422588/vuph6u87zawbjuyFbRc__YHXt9jYl5u9n-ZBGPvbDOK2khTsPjRC_0r8fXAkVEKBn9GE',
            ['Psico'] = 'https://discord.com/api/webhooks/1315116802350514256/regJPy1twSQdxN5m2rhNGj4J-HR6kZNkEuCkLL1LSmPYqsMnh9oCVqQZDUOrlAH5sSPX',
        },
             
        VEHICLE = "",
        HOUSE = "",
        inspect = "",
        pickup = "",
    },

    

    colors = {
        red = 16711680,
        green = 65280,
        blue = 255,
        cyan = 35554,
        rose = 13798114,
        yellow = 16776960
    }
}, {
    __call = function(self, config_name, fields, color, username, content)
        local webhook
        if type(config_name) == "string" then 
            webhook = self.config[config_name]
            if not webhook then 
                return --[[ print(("^1webhook config not found (%s) ^7"):format(config_name)) ]]
            end
        elseif type(config_name) == "table" then 
            webhook = self.config[config_name.main][config_name.sub]
            if not webhook then 
                return --[[ print(("^1webhook config not found (%s) ^7"):format(json.encode(config_name))) ]]
            end
        end
        local _color = ((color and self.colors[color]) and self.colors[color] or 16754176)

        if not content then 
            content = username
        end

        -- Log(webhook,message)
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({
            username = username or "Inventory Log",
            embeds = {
                {
                    color = _color,
                    description = "**"..content:upper().."**"
                }
            }}),
            { ['Content-Type'] = 'application/json' }
        );
    end
})



CoopChests = {
    federal = true,
    convencional = true,
    elite = true
}





-- Webhook({main = "chests", sub = string.gsub(chest_name, "orgChest:","") }, "blue", "#"..user_id.." "..identity.nome.." "..identity.sobrenome, "Guardou "..amount.."x "..slot_data.item.." no baú.")
