import Item from '@/components/item'
import Bag from '../assets/bag.svg'
import Ilegal from '../assets/ilegal.svg'
import Logs from '../assets/logs.svg'
import ItemPut from '@/components/item-put'
import { ItemProps } from '@/interfaces/interface'
import { useEffect, useState } from 'react'
import { emit } from '@/utils/emit'
import EditValue, { ModalProps } from '@/components/edit-value'
import { observe } from '@/hooks/observe'
import { isEnvBrowser } from '@/utils/misc'

export default function Home() {
  const [items, setItems] = useState<ItemProps[]>([])
  const [editItem, setEditItem] = useState<ModalProps | null>(null)
  const [bench, setBench] = useState<ItemProps[]>([])
  const [logs, setLogs] = useState<string[]>([])
  const [weight, setWeight] = useState(0)
  const [maxWeight, setMaxWeight] = useState(40)
  const [percent, setPercent] = useState(0)
  const [search, setSearch] = useState('')
  const [update, setUpdate] = useState(false)
  const filteredLogs = logs.filter((log) => {
    return log.toLowerCase().includes(search.toLowerCase())
  })

  useEffect(() => {
    emit(
      'PICK_UP_SALES_COUNTER',
      {},
      {
        inventory: [
          {
            name: 'Coca-Cola',
            image: 'https://i.imgur.com/6Z7R2VQ.png',
            amount: 10,
            weight: 1.5,
            value: 10,
          },
          {
            name: 'Pepsi',
            image: 'https://i.imgur.com/6Z7R2VQ.png',
            amount: 10,
            weight: 1.5,
            value: 10,
          },
        ],
        bench: [
          {
            name: 'Coca-Cola',
            image: 'https://i.imgur.com/6Z7R2VQ.png',
            amount: 10,
            weight: 1.5,
            value: 10,
          },
        ],
        logs: ['Coca-Cola foi adicionado ao banco de dados'],
        weight: 11.32,
        maxWeight: 40,
      },
    ).then((res) => {
      setItems(res.inventory)
      console.log("res.bench")
      if(res.bench.length < 8) {
        for(let i = res.bench.length; i < 8; i++) {
          res.bench.push({
            name: '',
            image: '',
            amount: 0,
            weight: 0,
            value: 0,
          })
        }
        setBench(res.bench)
      }
      setLogs(res.logs)
      setWeight(res.weight)
      setMaxWeight(res.maxWeight)

      setPercent((res.weight / res.maxWeight) * 100)
    })
  }, [update])

  observe('UPDATE_BENCH', (data) => {
    const newData = [...data]
    if(data.length < 8) {
      console.log("inserindo item vazio")

      for(let i = data.length; i < 8; i++) {
        newData.push({
          name: '',
          image: '',
          amount: 0,
          weight: 0,
          value: 0,
        })
      }
    }
    setBench([])
    setTimeout(() => {
      setBench([...newData])
    }, 2);
  })
 
  observe('UPDATE_ITEMS', setItems)
  observe('UPDATE_WEIGHT', (data) => {
    setWeight(data.weight)
    setMaxWeight(data.maxWeight)
    setPercent((data.weight / data.maxWeight) * 100)
  })
  observe('UPDATE_LOGS', setLogs)
 

  return (
    <div className="flex gap-[1.8125rem] w-full h-full items-center justify-center">
      <div className="w-[32.75rem] space-y-4">
        <div className="flex w-full items-center justify-between">
          <img src={Bag} alt="" />
          <div className="flex items-center gap-3">
            <div className="w-20 h-8 bars bg-white/5">
              <div className="h-full gradient" style={{ width: percent }}></div>
            </div>
            <div>
              <p className="text-white/60 text-xs">PESO</p>
              <p className="text-white/40 text-xs">
                <span className="text-white font-bold text-lg">{weight}</span>/
                {maxWeight}
              </p>
            </div>
          </div>
        </div>
        <div className="grid grid-cols-5 gap-1.5 h-[42rem] overflow-y-auto overflow-x-hidden w-[103%]">
          {Array.from({ length: 128 }).map((_, index) => {
            const item = items[index]
            if (!item) {
              return (
                <div
                  key={index}
                  className="w-[6.25rem] h-[7.36481rem] bg-white/5 rounded-[0.3125rem] relative flex-none"
                  style={{
                    background:
                      'radial-gradient(149.41% 131.65% at -10.68% 1.97%, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(0deg, rgba(255, 255, 255, 0.07) 0%, rgba(255, 255, 255, 0.07) 100%), rgba(0, 0, 0, 0.13)',
                  }}
                >
                  <img
                    src=""
                    className="max-h-[4.5625rem] absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2"
                    alt=""
                  />
                </div>
              )
            }

            return <Item {...item} key={index} />
          })}
        </div>
      </div>
      <div className="space-y-4">
        <img src={Ilegal} alt="" />
        <div className="h-[42rem] flex flex-col gap-2.5 overflow-y-auto overflow-x-hidden w-[101%]">
          {
            bench.map((item, index, array) => {
              if(!item.name || item.name === ''){
                return (
                  <div
                    key={index}
                    className="w-[26.625rem] h-[9.375rem] flex-none rounded flex items-center justify-center gap-3 bg-white/5"
                  >
                    <svg
                      width="30"
                      height="30"
                      viewBox="0 0 30 30"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path
                        d="M13.7917 24.6667C13.7917 24.9871 13.919 25.2945 14.1456 25.5211C14.3722 25.7477 14.6795 25.875 15 25.875C15.3205 25.875 15.6278 25.7477 15.8544 25.5211C16.081 25.2945 16.2083 24.9871 16.2083 24.6667V16.2083H24.6667C24.9871 16.2083 25.2945 16.081 25.5211 15.8544C25.7477 15.6278 25.875 15.3205 25.875 15C25.875 14.6795 25.7477 14.3722 25.5211 14.1456C25.2945 13.919 24.9871 13.7917 24.6667 13.7917H16.2083V5.33333C16.2083 5.01286 16.081 4.70552 15.8544 4.47891C15.6278 4.25231 15.3205 4.125 15 4.125C14.6795 4.125 14.3722 4.25231 14.1456 4.47891C13.919 4.70552 13.7917 5.01286 13.7917 5.33333V13.7917H5.33333C5.01286 13.7917 4.70552 13.919 4.47891 14.1456C4.25231 14.3722 4.125 14.6795 4.125 15C4.125 15.3205 4.25231 15.6278 4.47891 15.8544C4.70552 16.081 5.01286 16.2083 5.33333 16.2083H13.7917V24.6667Z"
                        fill="#DDDDDD"
                        fillOpacity="0.3"
                      />
                    </svg>
                    <p className="text-white/30 font-heading text-[1.625rem]">
                      ADICIONAR ITEM
                    </p>
                  </div>
                ) 
              }
              return <ItemPut setEditItem={setEditItem} item={item} key={index} />
            })
          }
         
        </div>
      </div>
      <div
        className="w-[36.875rem] h-[42.25rem] rounded mt-[5rem] p-5"
        style={{
          background:
            'radial-gradient(149.41% 131.65% at -10.68% 1.97%, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(0deg, rgba(255, 255, 255, 0.07) 0%, rgba(255, 255, 255, 0.07) 100%), rgba(0, 0, 0, 0.13)',
        }}
      >
        <div className="w-full flex items-center justify-between">
          <img src={Logs} alt="" />
          <div
            className="w-[16.875rem] h-[2.5rem] rounded p-3 flex items-center gap-3 border border-white/10"
            style={{
              background:
                'linear-gradient(90deg, rgba(255, 255, 255, 0.06) 0%, rgba(255, 255, 255, 0.05) 100%)',
            }}
          >
            <svg
              width="16"
              height="16"
              viewBox="0 0 16 16"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M11.3333 11.3333L14 14M2 7.33333C2 8.74782 2.5619 10.1044 3.5621 11.1046C4.56229 12.1048 5.91885 12.6667 7.33333 12.6667C8.74782 12.6667 10.1044 12.1048 11.1046 11.1046C12.1048 10.1044 12.6667 8.74782 12.6667 7.33333C12.6667 5.91885 12.1048 4.56229 11.1046 3.5621C10.1044 2.5619 8.74782 2 7.33333 2C5.91885 2 4.56229 2.5619 3.5621 3.5621C2.5619 4.56229 2 5.91885 2 7.33333Z"
                stroke="white"
                strokeOpacity="0.8"
                strokeWidth="1.25"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
            <input
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Buscar"
              type="text"
              className="bg-transparent outline-none placeholder:text-white/80 text-sm text-white"
            />
          </div>
        </div>
        <div className="mt-5">
          <p className="text-white/60 text-sm">Descrição</p>
          <div className="mt-4 flex flex-col gap-1.5  h-[32rem] overflow-y-auto overflow-x-hidden w-[102%]">
            {filteredLogs.map((log, index) => {
              return (
                <div
                  key={index}
                  className="w-[34.375rem] h-[2.875rem] rounded border border-white/15 p-4 flex items-center"
                  style={{
                    background:
                      'linear-gradient(90deg, rgba(255, 255, 255, 0.00) 0%, rgba(255, 255, 255, 0.00) 100%)',
                  }}
                >
                  <p className="text-[#DDD] text-sm truncate">{log}</p>
                </div>
              )
            })}
          </div>
        </div>
      </div>
      {editItem && <EditValue {...editItem} />}
    </div>
  )
}
