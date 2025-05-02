import ArrestVehicle from '@/components/arrest-vehicle-modal'
import FinesModal from '@/components/fines-modal'
import { emit } from '@/utils/emit'
import dayjs from 'dayjs'
import { useEffect, useState } from 'react'
import { useSearchParams } from 'react-router-dom'

interface IVehicleProps {
  description: string
  officer: string
  date: number
}

interface IVehicle {
  plate: string
  owner: string
  fines: number
  apprehensions: number
  history: IVehicleProps[]
}

export default function Vehicle() {
  const [vehicle, setVehicle] = useState<IVehicle>()
  const [searchParams] = useSearchParams()
  const [finesModal, setFinesModal] = useState<boolean>(false)
  const [arrestModal, setArrestModal] = useState<boolean>(false)

  useEffect(() => {
    emit<IVehicle>(
      'getVehicle',
      {
        vehicle: searchParams.get('vehicle'),
        plate: searchParams.get('plate'),
      },
      {
        plate: 'ABC-1234',
        owner: 'Luiz Jesus',
        fines: 30000,
        apprehensions: 0,
        history: [
          {
            description: 'Devendo 30.000 em multas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Devendo 30.000 em multas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Devendo 30.000 em multas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Devendo 30.000 em multas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Devendo 30.000 em multas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Devendo 30.000 em multas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Devendo 30.000 em multas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
        ],
      },
    ).then((data) => setVehicle(data))
  }, [])

  return (
    <div className="w-[55.875rem] h-[35.625rem] muted-foreground p-3.5">
      <div className="w-[53.875rem] h-[11.5rem] rounded bg-white bg-opacity-[1%] flex items-center p-5">
        <img
          src=""
          className="w-[18.75rem] h-[9rem] bg-white/10 rounded"
          alt=""
        />
        <div className="w-[31.375rem] h-[9rem] rounded bg-white bg-opacity-[2%] ml-5 p-4">
          <div className="flex items-center">
            <div className="w-[15.1875rem]">
              <p className="text-xs text-zinc-500 font-bold">
                PLACA DO VEÍCULO
              </p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M3.75 8.75L4.875 5.375H13.125L14.25 8.75M13.125 12.5C12.8266 12.5 12.5405 12.3815 12.3295 12.1705C12.1185 11.9595 12 11.6734 12 11.375C12 11.0766 12.1185 10.7905 12.3295 10.5795C12.5405 10.3685 12.8266 10.25 13.125 10.25C13.4234 10.25 13.7095 10.3685 13.9205 10.5795C14.1315 10.7905 14.25 11.0766 14.25 11.375C14.25 11.6734 14.1315 11.9595 13.9205 12.1705C13.7095 12.3815 13.4234 12.5 13.125 12.5ZM4.875 12.5C4.57663 12.5 4.29048 12.3815 4.0795 12.1705C3.86853 11.9595 3.75 11.6734 3.75 11.375C3.75 11.0766 3.86853 10.7905 4.0795 10.5795C4.29048 10.3685 4.57663 10.25 4.875 10.25C5.17337 10.25 5.45952 10.3685 5.6705 10.5795C5.88147 10.7905 6 11.0766 6 11.375C6 11.6734 5.88147 11.9595 5.6705 12.1705C5.45952 12.3815 5.17337 12.5 4.875 12.5ZM14.19 5C14.04 4.565 13.62 4.25 13.125 4.25H4.875C4.38 4.25 3.96 4.565 3.81 5L2.25 9.5V15.5C2.25 15.6989 2.32902 15.8897 2.46967 16.0303C2.61032 16.171 2.80109 16.25 3 16.25H3.75C3.94891 16.25 4.13968 16.171 4.28033 16.0303C4.42098 15.8897 4.5 15.6989 4.5 15.5V14.75H13.5V15.5C13.5 15.6989 13.579 15.8897 13.7197 16.0303C13.8603 16.171 14.0511 16.25 14.25 16.25H15C15.1989 16.25 15.3897 16.171 15.5303 16.0303C15.671 15.8897 15.75 15.6989 15.75 15.5V9.5L14.19 5Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="font-bold text-white">{vehicle?.plate}</p>
              </div>
            </div>
            <div>
              <p className="text-xs text-zinc-500 font-bold">PROPRIETÁRIO</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M3.75 8.75L4.875 5.375H13.125L14.25 8.75M13.125 12.5C12.8266 12.5 12.5405 12.3815 12.3295 12.1705C12.1185 11.9595 12 11.6734 12 11.375C12 11.0766 12.1185 10.7905 12.3295 10.5795C12.5405 10.3685 12.8266 10.25 13.125 10.25C13.4234 10.25 13.7095 10.3685 13.9205 10.5795C14.1315 10.7905 14.25 11.0766 14.25 11.375C14.25 11.6734 14.1315 11.9595 13.9205 12.1705C13.7095 12.3815 13.4234 12.5 13.125 12.5ZM4.875 12.5C4.57663 12.5 4.29048 12.3815 4.0795 12.1705C3.86853 11.9595 3.75 11.6734 3.75 11.375C3.75 11.0766 3.86853 10.7905 4.0795 10.5795C4.29048 10.3685 4.57663 10.25 4.875 10.25C5.17337 10.25 5.45952 10.3685 5.6705 10.5795C5.88147 10.7905 6 11.0766 6 11.375C6 11.6734 5.88147 11.9595 5.6705 12.1705C5.45952 12.3815 5.17337 12.5 4.875 12.5ZM14.19 5C14.04 4.565 13.62 4.25 13.125 4.25H4.875C4.38 4.25 3.96 4.565 3.81 5L2.25 9.5V15.5C2.25 15.6989 2.32902 15.8897 2.46967 16.0303C2.61032 16.171 2.80109 16.25 3 16.25H3.75C3.94891 16.25 4.13968 16.171 4.28033 16.0303C4.42098 15.8897 4.5 15.6989 4.5 15.5V14.75H13.5V15.5C13.5 15.6989 13.579 15.8897 13.7197 16.0303C13.8603 16.171 14.0511 16.25 14.25 16.25H15C15.1989 16.25 15.3897 16.171 15.5303 16.0303C15.671 15.8897 15.75 15.6989 15.75 15.5V9.5L14.19 5Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="font-bold text-white">{vehicle?.owner}</p>
              </div>
            </div>
          </div>
          <hr className="w-[29.125rem] h-[0.0625rem] bg-white/5 border-none my-4" />
          <div className="flex items-center ">
            <div className="w-[15.1875rem]">
              <p className="text-xs text-zinc-500 font-bold">MULTAS</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M3.75 8.75L4.875 5.375H13.125L14.25 8.75M13.125 12.5C12.8266 12.5 12.5405 12.3815 12.3295 12.1705C12.1185 11.9595 12 11.6734 12 11.375C12 11.0766 12.1185 10.7905 12.3295 10.5795C12.5405 10.3685 12.8266 10.25 13.125 10.25C13.4234 10.25 13.7095 10.3685 13.9205 10.5795C14.1315 10.7905 14.25 11.0766 14.25 11.375C14.25 11.6734 14.1315 11.9595 13.9205 12.1705C13.7095 12.3815 13.4234 12.5 13.125 12.5ZM4.875 12.5C4.57663 12.5 4.29048 12.3815 4.0795 12.1705C3.86853 11.9595 3.75 11.6734 3.75 11.375C3.75 11.0766 3.86853 10.7905 4.0795 10.5795C4.29048 10.3685 4.57663 10.25 4.875 10.25C5.17337 10.25 5.45952 10.3685 5.6705 10.5795C5.88147 10.7905 6 11.0766 6 11.375C6 11.6734 5.88147 11.9595 5.6705 12.1705C5.45952 12.3815 5.17337 12.5 4.875 12.5ZM14.19 5C14.04 4.565 13.62 4.25 13.125 4.25H4.875C4.38 4.25 3.96 4.565 3.81 5L2.25 9.5V15.5C2.25 15.6989 2.32902 15.8897 2.46967 16.0303C2.61032 16.171 2.80109 16.25 3 16.25H3.75C3.94891 16.25 4.13968 16.171 4.28033 16.0303C4.42098 15.8897 4.5 15.6989 4.5 15.5V14.75H13.5V15.5C13.5 15.6989 13.579 15.8897 13.7197 16.0303C13.8603 16.171 14.0511 16.25 14.25 16.25H15C15.1989 16.25 15.3897 16.171 15.5303 16.0303C15.671 15.8897 15.75 15.6989 15.75 15.5V9.5L14.19 5Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="font-bold text-white">{vehicle?.fines}</p>
              </div>
            </div>
            <div>
              <p className="text-xs text-zinc-500 font-bold">APREENSÕES</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M3.75 8.75L4.875 5.375H13.125L14.25 8.75M13.125 12.5C12.8266 12.5 12.5405 12.3815 12.3295 12.1705C12.1185 11.9595 12 11.6734 12 11.375C12 11.0766 12.1185 10.7905 12.3295 10.5795C12.5405 10.3685 12.8266 10.25 13.125 10.25C13.4234 10.25 13.7095 10.3685 13.9205 10.5795C14.1315 10.7905 14.25 11.0766 14.25 11.375C14.25 11.6734 14.1315 11.9595 13.9205 12.1705C13.7095 12.3815 13.4234 12.5 13.125 12.5ZM4.875 12.5C4.57663 12.5 4.29048 12.3815 4.0795 12.1705C3.86853 11.9595 3.75 11.6734 3.75 11.375C3.75 11.0766 3.86853 10.7905 4.0795 10.5795C4.29048 10.3685 4.57663 10.25 4.875 10.25C5.17337 10.25 5.45952 10.3685 5.6705 10.5795C5.88147 10.7905 6 11.0766 6 11.375C6 11.6734 5.88147 11.9595 5.6705 12.1705C5.45952 12.3815 5.17337 12.5 4.875 12.5ZM14.19 5C14.04 4.565 13.62 4.25 13.125 4.25H4.875C4.38 4.25 3.96 4.565 3.81 5L2.25 9.5V15.5C2.25 15.6989 2.32902 15.8897 2.46967 16.0303C2.61032 16.171 2.80109 16.25 3 16.25H3.75C3.94891 16.25 4.13968 16.171 4.28033 16.0303C4.42098 15.8897 4.5 15.6989 4.5 15.5V14.75H13.5V15.5C13.5 15.6989 13.579 15.8897 13.7197 16.0303C13.8603 16.171 14.0511 16.25 14.25 16.25H15C15.1989 16.25 15.3897 16.171 15.5303 16.0303C15.671 15.8897 15.75 15.6989 15.75 15.5V9.5L14.19 5Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="font-bold text-white">{vehicle?.apprehensions}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="w-[53.875rem] h-[20.3125rem] rounded bg-white bg-opacity-[1%] mt-4 p-4">
        <div className="w-[51.875rem] h-[1.5rem] rounded bg-white bg-opacity-[3%] flex items-center px-5">
          <p className="text-[0.625rem] text-zinc-500 font-bold w-[26.6875rem]">
            HISTÓRICO
          </p>
          <p className="text-[0.625rem] text-zinc-500 font-bold w-[11.5rem]">
            OFICIAL
          </p>
          <p className="text-[0.625rem] text-zinc-500 font-bold">DATA</p>
        </div>
        <div className="flex flex-col gap-3 mt-3 overflow-y-auto overflow-x-hidden h-[12.8125rem] w-[101%]">
          {vehicle?.history?.map((veh, index) => {
            return (
              <div
                key={index}
                className="flex w-[51.875rem] h-[2.375rem] rounded bg-white bg-opacity-[2%] items-center px-5 flex-none"
              >
                <p className="text-xs text-white font-bold w-[25.3125rem]">
                  {veh.description}
                </p>
                <p className="text-xs text-white font-bold w-[12.875rem]">
                  {veh.officer}
                </p>
                <p className="text-xs text-white font-bold">
                  {dayjs(veh.date * 1000).format('DD/MM/YYYY - HH:mm')}
                </p>
              </div>
            )
          })}
        </div>
        <div className="flex items-center gap-4 mt-3">
          <button
            onClick={() => setFinesModal(true)}
            className="w-[25.4375rem] h-[2.625rem] rounded bg-white bg-opacity-[2%] text-sm text-white font-bold"
          >
            APLICAR MULTA
          </button>
          <button
            onClick={() => setArrestModal(true)}
            className="w-[25.4375rem] h-[2.625rem] rounded bg-white bg-opacity-[2%] text-sm text-white font-bold"
          >
            APREENDER VEÍCULO
          </button>
        </div>
      </div>
      {finesModal && (
        <FinesModal
          vehicle={searchParams.get('vehicle')!}
          plate={vehicle!.plate}
          setShowModal={setFinesModal}
        />
      )}
      {arrestModal && (
        <ArrestVehicle
          vehicle={searchParams.get('vehicle')!}
          plate={vehicle!.plate}
          setShowModal={setArrestModal}
        />
      )}
    </div>
  )
}
