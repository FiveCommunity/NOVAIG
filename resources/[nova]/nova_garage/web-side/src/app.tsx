import Speed from '/icons/speed.svg'
import Search from '/icons/search.svg'

import { MdOutlineStar } from "react-icons/md";

import { useEffect, useMemo, useState } from 'react'

import { useGarage } from './hooks/useGarage'
import fetch from './utils/fetch'


import { Vehicle } from './components/vehicle'
import { LendVehicleButton } from './components/modals/lend-vehicle-modal'
import { SellVehicleButton } from './components/modals/sell-vehicle-modal'

import Example from '/images/default_vehicle.webp'

export function App() {
  const [search, setSearch] = useState<string>('')
  const [selection, setSelection] = useState<'special' | 'normal' | 'favorite' | null>(null)
  const [vehicleSelected, setVehicleSelected] = useState<number>(0)
  const [favoriteVehicles, setFavoriteVehicles] = useState<string[]>(JSON.parse(localStorage.getItem('favorited_vehicles') || '[]'))

  const { vehicles } = useGarage()

  const vehicleFiltered = useMemo(() => {
    return vehicles
      .filter(({ type }) => selection === null || selection === 'favorite' || type === selection)
      .filter(({ key }) => selection !== 'favorite' || favoriteVehicles.includes(key))
      .filter(({ name }) => name.toLowerCase().includes(search.toLowerCase()))
  }, [vehicles, search, selection, favoriteVehicles])

  const handleFavoriteVehicle = (plate: string) => {
    if (favoriteVehicles.includes(plate)) {
      setFavoriteVehicles((prevState) => prevState.filter((currentPlate) => currentPlate !== plate))
    } else {
      setFavoriteVehicles((prevState) => [plate, ...prevState])
    }

    localStorage.setItem('favorited_vehicles', JSON.stringify(favoriteVehicles))
  }

  useEffect(() => {
    setVehicleSelected(0)
  }, [selection])

  return (
    <div className='w-[96.875rem] rounded-[0.3125rem] bg-gradient-to-r from-[#030303ED] to-[#030303E4] pt-[1.88rem] pb-[1.87rem] px-[1.87rem] flex items-start justify-center gap-16 relative'>
      <div className='w-[31.25rem] flex flex-col items-center'>
        {vehicleFiltered.length > 0 && (
          <>
            <div className='w-full mb-7'>
              <div className='flex items-center gap-2'>
                <p className='text-white text-[2.1875rem] font-extrabold leading-none'>{vehicleFiltered[vehicleSelected]?.name}</p>
                {favoriteVehicles.includes(vehicleFiltered[vehicleSelected]?.key) && <MdOutlineStar className='size-[1.3125rem] text-primary'/>}
              </div>
              <small className='text-white/70 text-xs font-normal'>PLACA: <b className='text-white font-semibold'>{vehicleFiltered[vehicleSelected]?.plate}</b></small>
            </div>
            <img src={vehicleFiltered[vehicleSelected].image_url || ''} draggable={false} onError={(e) => e.currentTarget.src = './images/default_vehicle.webp'} className='h-[16.125rem]' />
            <div className='mt-[1.87rem]'>
              <div className='flex items-center gap-10 w-full overflow-x-hidden'>
                <div>
                  <p className='text-white text-[1.3125rem] font-bold leading-none'>{vehicleFiltered[vehicleSelected]?.arrested ? 'PRESO' : 'LIBERADO'}</p>
                  <small className='text-white/70 text-[0.6875rem]'>STATUS</small>
                </div>
                <div>
                  <p className='text-white text-[1.3125rem] font-bold leading-none'>{vehicleFiltered[vehicleSelected]?.ipva ? 'NÃO PAGO' : 'PAGO'}</p>
                  <small className='text-white/70 text-[0.6875rem]'>IPVA</small>
                </div>
                <div>
                  <p className='text-white text-[1.3125rem] font-bold leading-none uppercase truncate w-[6rem]'>{vehicleFiltered[vehicleSelected]?.category}</p>
                  <small className='text-white/70 text-[0.6875rem]'>TIPO</small>
                </div>
              </div>
              <div className='flex flex-col gap-[.94rem] mt-[1.56rem] w-[27.5rem]'>
                <div className='w-full flex flex-col gap-[.62rem]'>
                  <div className='flex items-center justify-between'>
                    <p className='text-white text-xs font-bold'>FRENAGEM</p>
                    <p className='text-white/50 text-xs font-normal'>{vehicleFiltered[vehicleSelected]?.braking}%</p>
                  </div>
                  <div className='w-full h-[0.5625rem] rounded-[0.1875rem] bg-gradient-to-r from-[#00000080] to-[#0000006C] overflow-hidden'>
                    <div className='h-full bg-primary rounded-[0.0625rem]' style={{ width: `${Math.min(vehicleFiltered[vehicleSelected]?.braking, 100)}%`}}></div>
                  </div>
                </div>
                <div className='w-full flex flex-col gap-[.62rem]'>
                  <div className='flex items-center justify-between'>
                    <p className='text-white text-xs font-bold'>ACELERAÇÃO</p>
                    <p className='text-white/50 text-xs font-normal'>{vehicleFiltered[vehicleSelected]?.agility}%</p>
                  </div>
                  <div className='w-full h-[0.5625rem] rounded-[0.1875rem] bg-gradient-to-r from-[#00000080] to-[#0000006C] overflow-hidden'>
                    <div className='h-full bg-primary rounded-[0.0625rem]' style={{ width: `${Math.min(vehicleFiltered[vehicleSelected]?.agility, 100)}%`}}></div>
                  </div>
                </div>
                <div className='w-full flex flex-col gap-[.62rem]'>
                  <div className='flex items-center justify-between'>
                    <p className='text-white text-xs font-bold'>ADERÊNCIA</p>
                    <p className='text-white/50 text-xs font-normal'>{vehicleFiltered[vehicleSelected]?.grip}%</p>
                  </div>
                  <div className='w-full h-[0.5625rem] rounded-[0.1875rem] bg-gradient-to-r from-[#00000080] to-[#0000006C] overflow-hidden'>
                    <div className='h-full bg-primary' style={{ width: `${Math.min(vehicleFiltered[vehicleSelected]?.grip, 100)}%`}}></div>
                  </div>
                </div>
              </div>
              <div className='flex items-center gap-[.62rem] mt-[1.62rem]'>
                <img src={Speed} />
                <div>
                  <p className='text-white/70 text-[0.6875rem] font-normal uppercase'>Velocidade máxima</p>
                  <h3 className='text-white text-[2.8125rem] font-extrabold leading-none'>{vehicleFiltered[vehicleSelected]?.max_speed}km/h</h3>
                </div>
              </div>
              <div className='flex flex-col gap-2 mt-[1.78rem]'>
                <div className='flex items-center gap-2'>
                  <LendVehicleButton vehicle={vehicleFiltered[vehicleSelected]} />
                  <button className='text-white/60 text-xs font-bold rounded-sm h-[2.8125rem] border-[.05rem] border-white/15 flex-1 hover:!bg-primary-gradient hover:!border-primary hover:!text-white bg-white/[.13]' onClick={() => fetch('TAKE_OUT', vehicleFiltered[vehicleSelected])}>RETIRAR</button>
                  <button className='text-white/60 text-xs font-bold rounded-sm h-[2.8125rem] border-[.05rem] border-white/15 flex-1 hover:!bg-primary-gradient hover:!border-primary hover:!text-white bg-white/[.13]' onClick={() => fetch('PULL', vehicleFiltered[vehicleSelected])}>GUARDAR</button>
                </div>
                <div className='flex items-center gap-2'>
                  <SellVehicleButton vehicle={vehicleFiltered[vehicleSelected]} />
                  <button className='text-white/60 text-xs font-bold rounded-sm h-[2.8125rem] border-[.05rem] border-white/15 flex-1 hover:!bg-primary-gradient hover:!border-primary hover:!text-white bg-white/[.13]' onClick={() => fetch('PULL_NEAREST')}>GUARDAR PRÓXIMO</button>
                </div>
              </div>
            </div>
          </>
        )}
      </div>
      <div className='w-[55.625rem] flex-none flex flex-col gap-[.63rem]'>
        <div className='w-full flex items-center justify-between h-9'>
          <div className='flex items-center gap-[.44rem] h-full'>
            <div className='w-[23.125rem] h-full flex items-center gap-[.31rem] px-[.62rem] rounded-sm border-[.05rem] border-white/15 bg-white/[.08]'>
              <img src={Search} />
              <input type="text" onChange={(e) => setSearch(e.target.value)} placeholder='PESQUISAR' className='bg-transparent border-none outline-none text-[0.6875rem] text-white placeholder:text-white/60'/>
            </div>
            <div className='h-full p-[.31rem] rounded-sm border-[.05rem] border-white/15 bg-white/[.08]'>
              <button onClick={() => setSelection(prevState => prevState === 'normal' ? null : 'normal')} className={`${selection === 'normal' && '!bg-primary-gradient !border-primary !text-white'} text-white/70 text-[0.6875rem] font-bold h-full px-[.94rem] rounded-sm hover:!bg-primary-gradient hover:!text-white hover:border-primary`}>CONCE</button>
              <button onClick={() => setSelection(prevState => prevState === 'special' ? null : 'special')} className={`${selection === 'special' && '!bg-primary-gradient !border-primary !text-white'} text-white/70 text-[0.6875rem] font-bold h-full px-[.94rem] rounded-sm hover:!bg-primary-gradient hover:!text-white hover:border-primary`}>VIP</button>
            </div>
          </div>
          <div onClick={() => setSelection(prevState => prevState === 'favorite' ? null : 'favorite')} className={`${selection === 'favorite' && '!bg-primary-gradient !border-primary !text-white'} group size-9 flex items-center justify-center rounded-sm border-[.05rem] border-white/15 bg-white/[.08] cursor-pointer duration-300 hover:!bg-primary-gradient`}>
            <MdOutlineStar className={`${selection === 'favorite' && '!text-white'} size-5 text-white/30 group-hover:text-white`}/>
          </div>
        </div>
        <div className='w-[102%] flex-none max-h-[46.75rem] overflow-auto overflow-x-hidden flex flex-wrap content-start gap-[.62rem]'>
          {vehicleFiltered.map((vehicle, index) => (
            <Vehicle
              key={index}
              image_url={vehicle.image_url}
              name={vehicle.name}
              engine={vehicle.braking}
              category={vehicle.category}
              selected={vehicleSelected === index}
              favorited={favoriteVehicles.includes(vehicle.key)}
              onFavorite={() => handleFavoriteVehicle(vehicle.key)}
              onSelect={() => setVehicleSelected(index)}
            />
          )) }
        </div>
      </div>
    </div>
  )
}