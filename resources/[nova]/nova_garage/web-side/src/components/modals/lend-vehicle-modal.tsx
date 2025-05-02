import * as Dialog from '@radix-ui/react-dialog'
import clsx from 'clsx'
import { useRef } from 'react'
import { VehicleProps } from '../../hooks/useGarage'
import fetch from '../../utils/fetch';

import Car from '/icons/car.svg'

interface LendVehicleButtonProps {
  vehicle: VehicleProps;
}

export function LendVehicleButton({ vehicle }: LendVehicleButtonProps) {
  const inputUserRef = useRef<HTMLInputElement>(null)

  function handleConfirm() {
    fetch('LEND_VEHICLE', {
      vehicle,
      userId: Number(inputUserRef.current?.value)
    })
  }

  return (
    <Dialog.Root>
      <Dialog.Trigger
        className='disabled:opacity-20 disabled:pointer-events-none text-white/60 text-xs font-bold rounded-sm h-[2.8125rem] border-[.05rem] border-white/15 flex-1 hover:!bg-primary-gradient hover:!border-primary hover:!text-white bg-white/[.13]'
        disabled={vehicle.type === 'service'}
      >
        EMPRESTAR
      </Dialog.Trigger>
      <Dialog.Portal>
        <Dialog.Overlay className="fixed inset-0 bg-black/90" />
        <Dialog.Content
          className="fixed bg-gradient-to-r from-[#030303ED] to-[#030303E4] left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 flex flex-col items-center gap-5 p-[1.875rem] rounded-sm focus:outline-none"
        >
          <div className='flex items-center justify-center size-[2.625rem] rounded-sm border-[.0625rem] border-primary bg-primary-gradient shadow-primary'>
            <img src={Car} className='size-[1.625rem]'/>
          </div>
          <div className="flex flex-col gap-2 text-center">
            <Dialog.Title asChild>
              <h4 className="text-white font-extrabold text-[1.875rem] leading-[1rem] uppercase">{vehicle.name}</h4>
            </Dialog.Title>
          </div>
          <Dialog.Description asChild>
            <p className="text-white/70 text-[.6875rem] text-center uppercase">Insira o id de quem deseja <strong className="font-semibold text-white/90">emprestar a chave</strong> <br /> do seu veículo.</p>
          </Dialog.Description>
          <div className="w-[21.25rem] flex flex-col gap-2 items-end">
            <input
              ref={inputUserRef}
              type="number"
              min={0}
              className="border-[.0313rem] border-white/25 w-full h-[3.125rem] bg-white/[.08] text-xs leading-[normal] focus:outline-none px-4 rounded-sm text-white placeholder:text-white/60 font-normal"
              placeholder="ID DO JOGADOR"
            />
            <div className="flex items-center gap-2 h-[2.8125rem] w-full">
              <Dialog.Close asChild>
                <button className="uppercase flex-1 h-full rounded-sm bg-white/[.13] grid place-items-center font-bold text-xs leading-[normal] border-[.0313rem] border-white/25 text-white/80">Cancelar</button>
              </Dialog.Close>
              <Dialog.Close asChild>
                <button className="flex-1 h-full rounded-sm bg-primary-gradient border-[.0625rem] border-primary shadow-primary grid place-items-center font-bold text-xs leading-[normal] text-white" onClick={handleConfirm}>CONFIRMAR</button>
              </Dialog.Close>
            </div>
          </div>
        </Dialog.Content>
      </Dialog.Portal>
    </Dialog.Root>
  )
}