import { emit } from '@/utils/emit'
import { X } from 'lucide-react'
import { useState } from 'react'

interface Props {
  vehicle: string
  plate: string
  setShowModal: (value: boolean) => void
}

export default function FinesModal({ vehicle, plate, setShowModal }: Props) {
  const [reason, setReason] = useState<string>('')
  const [amount, setAmount] = useState<number | null>(null)

  function handleFine() {
    if (!amount || !reason) return

    emit('fineVehicle', {
      vehicle,
      reason,
      amount,
      plate,
    })

    setShowModal(false)
  }

  return (
    <div className="w-[450px] h-[224px] bg-[#15151A] rounded absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 transform p-4">
      <div className="flex items-center gap-2">
        <div className="w-[23.5rem] h-[2.125rem] bg-white bg-opacity-[3%] rounded text-white/50 font-bold text-center flex items-center justify-center text-sm">
          APLICAR MULTA
        </div>
        <div
          onClick={() => setShowModal(false)}
          className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center cursor-pointer"
        >
          <X className="w-4 text-zinc-700" />
        </div>
      </div>
      <input
        onChange={(e) => setReason(e.target.value)}
        type="text"
        placeholder="Motivo"
        className="w-[26.125rem] h-[2.625rem] rounded bg-white bg-opacity-[2%] outline-none text-white px-3 placeholder:text-white mt-3"
      />
      <input
        onChange={(e) => setAmount(Number(e.target.value))}
        type="number"
        placeholder="Valor da multa"
        className="w-[26.125rem] h-[2.625rem] rounded bg-white bg-opacity-[2%] outline-none text-white px-3 placeholder:text-white mt-3"
      />
      <button
        onClick={handleFine}
        className="w-[26.125rem] h-[2.625rem] rounded bg-[#06F] text-white font-bold mt-2.5"
      >
        MULTAR VEÍCULO
      </button>
    </div>
  )
}
