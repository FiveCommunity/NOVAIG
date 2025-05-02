import { ItemProps } from '@/interfaces/interface'
import { emit } from '@/utils/emit'
import clsx from 'clsx'
import { useState } from 'react'

interface Props {
  item: ItemProps
}

export default function Item(item: any) {
  const { amount, image, name, value, weight, selected } = item
  const [thisItem, setThisItem] = useState<any>(item)

  function handlePut() {
    setThisItem({
      ...thisItem,
      selected: false,
    })
    emit('PUT_ON_BENCH', { item: thisItem })
  }

  return (
    <div
      onClick={handlePut}
      className={clsx(
        'w-[6.25rem] h-[7.36481rem] bg-white/5 rounded-[0.3125rem] relative cursor-pointer',
        {
          'selected pointer-events-none': thisItem.selected,
        },
      )}
      style={{
        background:
          'radial-gradient(149.41% 131.65% at -10.68% 1.97%, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(0deg, rgba(255, 255, 255, 0.07) 0%, rgba(255, 255, 255, 0.07) 100%), rgba(0, 0, 0, 0.13)',
      }}
    >
      <p className="text-[0.5625rem] text-white font-bold absolute top-2 left-2">
        {weight}KG
      </p>
      <p className="text-[0.5625rem] text-white/60 absolute top-2 right-2">
        {amount}x
      </p>
      <img
        src={image}
        className={clsx(
          'max-h-[4.5625rem] absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2',
          {
            'opacity-50': thisItem.selected,
          },
        )}
        alt=""
      />
      {thisItem.selected && (
        <svg
          className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2"
          width="38"
          height="39"
          viewBox="0 0 38 39"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M19.0001 4.08505C27.7084 4.08505 34.8334 11.2101 34.8334 19.9184C34.8334 28.6267 27.7084 35.7517 19.0001 35.7517C10.2918 35.7517 3.16675 28.6267 3.16675 19.9184C3.16675 11.2101 10.2918 4.08505 19.0001 4.08505ZM19.0001 7.25172C15.9918 7.25172 13.3001 8.20172 11.2418 9.94339L28.9751 27.6767C30.5584 25.4601 31.6668 22.7684 31.6668 19.9184C31.6668 12.9517 25.9668 7.25172 19.0001 7.25172ZM26.7584 29.8934L9.02508 12.1601C7.28342 14.2184 6.33342 16.9101 6.33342 19.9184C6.33342 26.8851 12.0334 32.5851 19.0001 32.5851C22.0084 32.5851 24.7001 31.6351 26.7584 29.8934Z"
            fill="white"
            fillOpacity="0.5"
          />
        </svg>
      )}
      {thisItem.selected && (
        <p className="text-white/60 text-sm absolute left-1/2 top-[84%] -translate-x-1/2 -translate-y-1/2">
          Selecionado
        </p>
      )}
    </div>
  )
}
