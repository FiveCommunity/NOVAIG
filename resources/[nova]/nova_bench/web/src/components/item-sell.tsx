import { ItemProps } from '@/interfaces/interface'
import { emit } from '@/utils/emit'
import { useState } from 'react'

interface ItemPutProps {
  item: ItemProps
}

export default function ItemSell({ item }: ItemPutProps) {
  const [amount, setAmount] = useState(1)
  function handleAmount(e: React.ChangeEvent<HTMLInputElement>) {
    if(Number(e.target.value) > item.amount || Number(e.target.value) <= 0) {
      e.target.value = item.amount.toString()
      e.target.select()
      return
    }
    setAmount(Number(e.target.value))
  }
  function handleBuy() {
    emit('BUY_ITEM', {
      item: {
        ...item,
        amount,
      },
    })
  }

  return (
    <div
      className="w-[26.625rem] h-[9.375rem] rounded-sm p-4 flex-none flex items-center relative"
      style={{
        background:
          'radial-gradient(149.41% 131.65% at -10.68% 1.97%, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(0deg, rgba(255, 255, 255, 0.07) 0%, rgba(255, 255, 255, 0.07) 100%), rgba(0, 0, 0, 0.13)',
      }}
    >
      <div
        className="w-[7.5rem] h-[7.5rem] rounded relative"
        style={{
          background:
            'linear-gradient(90deg, rgba(255, 255, 255, 0.15) 0%, rgba(255, 255, 255, 0.03) 100%)',
        }}
      >
        <div className="w-[3.125rem] h-[1.6875rem] gradient absolute right-0 top-0 rounded-[0rem_0.25rem_0rem_0.1875rem] border border-primary">
          <p className="text-xs text-white font-bold absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
            {item.amount}x
          </p>
        </div>
        <img
          className="max-h-[4.5rem] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
          src={item.image}
          alt=""
        />
      </div>
      <div className="ml-4">
        <div>
          <p className="text-white">{item.name}</p>
          <p className="text-[#DDD] text-sm">
            Valor unitário:{' '}
            {item.value?.toLocaleString('pt-br', {
              style: 'currency',
              currency: 'BRL',
              maximumFractionDigits: 0,
              minimumFractionDigits: 0,
            })}
          </p>
        </div>
        <div className="flex items-center gap-3">
          <p className="text-[1.625rem] text-white font-heading">
            {(amount * item.value).toLocaleString('pt-br', {
              style: 'currency',
              currency: 'BRL',
              maximumFractionDigits: 0,
              minimumFractionDigits: 0,
            })}
          </p>
        </div>
        <div className="flex items-center gap-3">
          <input
            type="number"
            onChange={handleAmount}
            onFocus={(e) => e.target.select()}
            max={item.amount}
            min={1}
            placeholder={String(amount)}
            className="w-[3.125rem] h-[2.25rem] rounded text-center placeholder:text-white/60 text-white px-2 outline-none"
            style={{
              background:
                'linear-gradient(90deg, rgba(255, 255, 255, 0.15) 0%, rgba(255, 255, 255, 0.03) 100%)',
            }}
          />
          <button
            onClick={handleBuy}
            className="flex items-center text-white rounded text-sm font-bold justify-center w-[12.6rem] h-[2.25rem] gradient border border-primary"
          >
            Adquirir
          </button>
        </div>
      </div>
    </div>
  )
}
