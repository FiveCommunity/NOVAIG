import { ItemProps } from '@/interfaces/interface'
import { ModalProps } from './edit-value'
import { emit } from '@/utils/emit'
import { useEffect, useState } from 'react'

interface ItemPutProps {
  setEditItem: (value: ModalProps | null) => void
  item: ItemProps
}

export default function ItemPut({ setEditItem, item }: ItemPutProps) {
  const [thisItem, setThisItem] = useState(item)
  const [amount, setAmount] = useState(thisItem.amount)
  function handleEdit() {
    setEditItem({
      value: thisItem.value,
      item: {
        ...item,
        amount,
      },
      setEditItem,
    })
  }


  function handleSell() {
    emit('SELL_ITEM', {
      item: {
        ...thisItem,
        amount,
        value: thisItem.value,
      },
    })
  }

  function handleDelete() {
    emit('REMOVE_ITEM', item)
  }

  function handleEditAmount(value: number) {
    if (value > thisItem.amount) {
      setAmount(thisItem.amount)
      return
    }
    if (value <= 0) {
      setAmount(thisItem.amount)
      return 
    }
    emit('EDIT_AMOUNT', {
      ...thisItem,
      new_amount: value,
    })

    setThisItem({
      ...thisItem,
      amount: value,
    })

    setAmount(value)
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
            {thisItem.amount}x
          </p>
        </div>
        <img
          className="max-h-[4.5rem] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2"
          src={thisItem.image}
          alt=""
        />
      </div>
      <div className="ml-4">
        <div>
          <p className="text-white">{thisItem.name}</p>
          <p className="text-[#DDD] text-sm">Quantidade: {thisItem.amount}x</p>
        </div>
        <div className="flex items-center gap-3">
          <p className="text-[1.625rem] text-white font-heading">
            {thisItem.value?.toLocaleString('pt-br', {
              style: 'currency',
              currency: 'BRL',
              maximumFractionDigits: 0,
              minimumFractionDigits: 0,
            })}
          </p>
          <svg
            className="cursor-pointer"
            onClick={handleEdit}
            width="26"
            height="27"
            viewBox="0 0 26 27"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <rect
              y="0.5"
              width="26"
              height="26"
              rx="3"
              fill="url(#paint0_linear_823_10231)"
              fillOpacity="0.15"
            />
            <rect
              x="0.35"
              y="0.85"
              width="25.3"
              height="25.3"
              rx="2.65"
              stroke="white"
              strokeOpacity="0.15"
              strokeWidth="0.7"
            />
            <path
              d="M7.75 16.5625V18.75H9.9375L16.3892 12.2983L14.2017 10.1108L7.75 16.5625ZM18.4892 10.1983L16.3017 8.01083L14.8258 9.4925L17.0133 11.68L18.4892 10.1983Z"
              fill="white"
            />
            <defs>
              <linearGradient
                id="paint0_linear_823_10231"
                x1="0"
                y1="13.5"
                x2="26"
                y2="13.5"
                gradientUnits="userSpaceOnUse"
              >
                <stop stopColor="white" />
                <stop offset="1" stopColor="white" stopOpacity="0.2" />
              </linearGradient>
            </defs>
          </svg>
        </div>
        <div className="flex items-center gap-3">
          <input
            type="number"
            // onChange={(e) => handleEditAmount(Number(e.target.value))}
            onKeyDown={(e) => {
              if (e.key === 'Enter') {
                handleEditAmount(Number(e.currentTarget.value))
              }
            }}
            placeholder={String(amount)}
            className="w-[3.125rem] h-[2.25rem] rounded text-center placeholder:text-white/60 text-white px-2 outline-none"
            style={{
              background:
                'linear-gradient(90deg, rgba(255, 255, 255, 0.15) 0%, rgba(255, 255, 255, 0.03) 100%)',
            }}
          />
        </div>
      </div>
      <svg
        onClick={handleDelete}
        className="absolute right-4 top-4 cursor-pointer"
        width="20"
        height="20"
        viewBox="0 0 20 20"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M13.3334 1.45833V2.5H17.7084C17.8742 2.5 18.0331 2.56585 18.1504 2.68306C18.2676 2.80027 18.3334 2.95924 18.3334 3.125C18.3334 3.29076 18.2676 3.44973 18.1504 3.56694C18.0331 3.68415 17.8742 3.75 17.7084 3.75H2.29175C2.12599 3.75 1.96702 3.68415 1.84981 3.56694C1.7326 3.44973 1.66675 3.29076 1.66675 3.125C1.66675 2.95924 1.7326 2.80027 1.84981 2.68306C1.96702 2.56585 2.12599 2.5 2.29175 2.5H6.66675V1.45833C6.66675 0.653333 7.32008 0 8.12508 0H11.8751C12.6801 0 13.3334 0.653333 13.3334 1.45833ZM7.91675 1.45833V2.5H12.0834V1.45833C12.0834 1.40308 12.0615 1.35009 12.0224 1.31102C11.9833 1.27195 11.9303 1.25 11.8751 1.25H8.12508C8.06983 1.25 8.01684 1.27195 7.97777 1.31102C7.9387 1.35009 7.91675 1.40308 7.91675 1.45833ZM4.16425 5.14833C4.15712 5.06605 4.13376 4.986 4.09551 4.9128C4.05726 4.8396 4.00488 4.77471 3.9414 4.72187C3.87792 4.66904 3.8046 4.62931 3.72568 4.60498C3.64675 4.58065 3.56378 4.57221 3.48158 4.58014C3.39937 4.58807 3.31954 4.61221 3.24672 4.65118C3.1739 4.69014 3.10952 4.74315 3.05731 4.80714C3.0051 4.87114 2.96609 4.94484 2.94254 5.024C2.91898 5.10316 2.91135 5.18621 2.92008 5.26833L4.09675 17.4333C4.13194 17.7939 4.30009 18.1285 4.56844 18.3719C4.83679 18.6153 5.18613 18.7501 5.54841 18.75H14.4517C14.8142 18.75 15.1636 18.6151 15.432 18.3716C15.7004 18.128 15.8684 17.7932 15.9034 17.4325L17.0809 5.26833C17.0968 5.10324 17.0465 4.93858 16.941 4.81059C16.8355 4.68259 16.6835 4.60175 16.5184 4.58583C16.3533 4.56992 16.1887 4.62024 16.0607 4.72573C15.9327 4.83122 15.8518 4.98324 15.8359 5.14833L14.6592 17.3117C14.6543 17.3632 14.6303 17.4111 14.5919 17.4459C14.5535 17.4808 14.5036 17.5 14.4517 17.5H5.54841C5.4966 17.5 5.44664 17.4808 5.40827 17.4459C5.3699 17.4111 5.34589 17.3632 5.34091 17.3117L4.16425 5.14833Z"
          fill="white"
          fillOpacity="0.5"
        />
        <path
          d="M7.6717 6.25082C7.75367 6.24597 7.8358 6.25733 7.91338 6.28423C7.99097 6.31114 8.06249 6.35307 8.12386 6.40763C8.18523 6.46219 8.23525 6.52831 8.27105 6.60221C8.30686 6.67611 8.32775 6.75634 8.33253 6.83832L8.7492 13.9217C8.75892 14.0873 8.70245 14.25 8.59219 14.374C8.48193 14.498 8.32693 14.5732 8.16128 14.5829C7.99563 14.5926 7.8329 14.5361 7.7089 14.4259C7.58489 14.3156 7.50976 14.1606 7.50003 13.995L7.08337 6.91165C7.07852 6.82968 7.08987 6.74756 7.11678 6.66997C7.14368 6.59239 7.18562 6.52087 7.24018 6.4595C7.29474 6.39813 7.36086 6.34811 7.43476 6.3123C7.50866 6.2765 7.58889 6.25561 7.67087 6.25082H7.6717ZM12.9159 6.91165C12.9256 6.746 12.8691 6.58328 12.7589 6.45927C12.6486 6.33526 12.4936 6.26013 12.3279 6.2504C12.1623 6.24068 11.9996 6.29716 11.8756 6.40741C11.7516 6.51767 11.6764 6.67267 11.6667 6.83832L11.25 13.9217C11.2403 14.0872 11.2967 14.2498 11.4069 14.3737C11.5171 14.4977 11.672 14.5728 11.8375 14.5825C12.0031 14.5922 12.1657 14.5358 12.2896 14.4256C12.4136 14.3154 12.4886 14.1605 12.4984 13.995L12.9159 6.91165Z"
          fill="white"
          fillOpacity="0.5"
        />
      </svg>
    </div>
  )
}
