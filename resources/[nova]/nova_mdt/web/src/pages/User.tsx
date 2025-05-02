import { emit } from '@/utils/emit'
import dayjs from 'dayjs'
import { useEffect, useState } from 'react'
import { useParams, useSearchParams } from 'react-router-dom'

interface IPassages {
  description: string
  officer: string
  date: number
}

interface IUser {
  name: string
  passport: number
  citizenSince: number
  vehicles: number
  criminalRecords: number
  gunLicense: boolean
  passages: IPassages[]
}

export default function User() {
  const [user, setUser] = useState<IUser>()
  const [searchParams, _] = useSearchParams()

  useEffect(() => {
    emit<IUser>(
      'getUser',
      { id: searchParams.get('id') },
      {
        name: 'Luiz Jesus',
        passport: 9999,
        citizenSince: 1720920864,
        vehicles: 5,
        criminalRecords: 9,
        gunLicense: false,
        passages: [
          {
            description: 'Matou 7 crianças atropeladas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Matou 7 crianças atropeladas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Matou 7 crianças atropeladas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Matou 7 crianças atropeladas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Matou 7 crianças atropeladas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Matou 7 crianças atropeladas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
          {
            description: 'Matou 7 crianças atropeladas',
            officer: 'Maka da Silva',
            date: 1720920864,
          },
        ],
      },
    ).then((response) => {
      setUser(response)
    })
  }, [])

  return (
    <div className="w-[55.875rem] h-[35.625rem] foreground p-4">
      <div className="w-[53.875rem] h-[11.5rem] bg-white bg-opacity-[1%] p-5 flex items-center gap-3">
        <img src="" className="w-[9rem] h-[9rem] rounded bg-white/50" alt="" />
        <div className="w-[41.625rem] h-[9rem] p-4 foreground rounded">
          <div className="flex items-center">
            <div className="w-[15.1875rem]">
              <p className="text-xs text-zinc-500 font-bold">NOME</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0.75 4.25C0.75 4.05109 0.829018 3.86032 0.96967 3.71967C1.11032 3.57902 1.30109 3.5 1.5 3.5H16.5C16.6989 3.5 16.8897 3.57902 17.0303 3.71967C17.171 3.86032 17.25 4.05109 17.25 4.25V14.75C17.25 14.9489 17.171 15.1397 17.0303 15.2803C16.8897 15.421 16.6989 15.5 16.5 15.5H1.5C1.30109 15.5 1.11032 15.421 0.96967 15.2803C0.829018 15.1397 0.75 14.9489 0.75 14.75V4.25ZM9.75 6.5V8H14.25V6.5H9.75ZM13.5 9.5H9.75V11H13.5V9.5ZM7.875 8C7.875 7.50272 7.67746 7.02581 7.32583 6.67417C6.97419 6.32254 6.49728 6.125 6 6.125C5.50272 6.125 5.02581 6.32254 4.67417 6.67417C4.32254 7.02581 4.125 7.50272 4.125 8C4.125 8.49728 4.32254 8.97419 4.67417 9.32582C5.02581 9.67746 5.50272 9.875 6 9.875C6.49728 9.875 6.97419 9.67746 7.32583 9.32582C7.67746 8.97419 7.875 8.49728 7.875 8ZM6 10.625C5.30381 10.625 4.63613 10.9016 4.14384 11.3938C3.65156 11.8861 3.375 12.5538 3.375 13.25H8.625C8.625 12.5538 8.34844 11.8861 7.85616 11.3938C7.36387 10.9016 6.69619 10.625 6 10.625Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="text-white font-bold">{user?.name}</p>
              </div>
            </div>
            <div className="w-[12.9375rem]">
              <p className="text-xs text-zinc-500 font-bold">PASSAPORTE</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0.75 4.25C0.75 4.05109 0.829018 3.86032 0.96967 3.71967C1.11032 3.57902 1.30109 3.5 1.5 3.5H16.5C16.6989 3.5 16.8897 3.57902 17.0303 3.71967C17.171 3.86032 17.25 4.05109 17.25 4.25V14.75C17.25 14.9489 17.171 15.1397 17.0303 15.2803C16.8897 15.421 16.6989 15.5 16.5 15.5H1.5C1.30109 15.5 1.11032 15.421 0.96967 15.2803C0.829018 15.1397 0.75 14.9489 0.75 14.75V4.25ZM9.75 6.5V8H14.25V6.5H9.75ZM13.5 9.5H9.75V11H13.5V9.5ZM7.875 8C7.875 7.50272 7.67746 7.02581 7.32583 6.67417C6.97419 6.32254 6.49728 6.125 6 6.125C5.50272 6.125 5.02581 6.32254 4.67417 6.67417C4.32254 7.02581 4.125 7.50272 4.125 8C4.125 8.49728 4.32254 8.97419 4.67417 9.32582C5.02581 9.67746 5.50272 9.875 6 9.875C6.49728 9.875 6.97419 9.67746 7.32583 9.32582C7.67746 8.97419 7.875 8.49728 7.875 8ZM6 10.625C5.30381 10.625 4.63613 10.9016 4.14384 11.3938C3.65156 11.8861 3.375 12.5538 3.375 13.25H8.625C8.625 12.5538 8.34844 11.8861 7.85616 11.3938C7.36387 10.9016 6.69619 10.625 6 10.625Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="text-white font-bold">{user?.passport}</p>
              </div>
            </div>
            <div>
              <p className="text-xs text-zinc-500 font-bold">CIDADÃO DESDE</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0.75 4.25C0.75 4.05109 0.829018 3.86032 0.96967 3.71967C1.11032 3.57902 1.30109 3.5 1.5 3.5H16.5C16.6989 3.5 16.8897 3.57902 17.0303 3.71967C17.171 3.86032 17.25 4.05109 17.25 4.25V14.75C17.25 14.9489 17.171 15.1397 17.0303 15.2803C16.8897 15.421 16.6989 15.5 16.5 15.5H1.5C1.30109 15.5 1.11032 15.421 0.96967 15.2803C0.829018 15.1397 0.75 14.9489 0.75 14.75V4.25ZM9.75 6.5V8H14.25V6.5H9.75ZM13.5 9.5H9.75V11H13.5V9.5ZM7.875 8C7.875 7.50272 7.67746 7.02581 7.32583 6.67417C6.97419 6.32254 6.49728 6.125 6 6.125C5.50272 6.125 5.02581 6.32254 4.67417 6.67417C4.32254 7.02581 4.125 7.50272 4.125 8C4.125 8.49728 4.32254 8.97419 4.67417 9.32582C5.02581 9.67746 5.50272 9.875 6 9.875C6.49728 9.875 6.97419 9.67746 7.32583 9.32582C7.67746 8.97419 7.875 8.49728 7.875 8ZM6 10.625C5.30381 10.625 4.63613 10.9016 4.14384 11.3938C3.65156 11.8861 3.375 12.5538 3.375 13.25H8.625C8.625 12.5538 8.34844 11.8861 7.85616 11.3938C7.36387 10.9016 6.69619 10.625 6 10.625Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="text-white font-bold">
                  {dayjs((user?.citizenSince || 0) * 1000).format('DD/MM/YYYY')}
                </p>
              </div>
            </div>
          </div>
          <hr className="w-[39.375rem] h-[0.0625rem] border-none bg-white/5 my-4" />
          <div className="flex items-center">
            <div className="w-[15.1875rem]">
              <p className="text-xs text-zinc-500 font-bold">VEÍCULOS</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0.75 4.25C0.75 4.05109 0.829018 3.86032 0.96967 3.71967C1.11032 3.57902 1.30109 3.5 1.5 3.5H16.5C16.6989 3.5 16.8897 3.57902 17.0303 3.71967C17.171 3.86032 17.25 4.05109 17.25 4.25V14.75C17.25 14.9489 17.171 15.1397 17.0303 15.2803C16.8897 15.421 16.6989 15.5 16.5 15.5H1.5C1.30109 15.5 1.11032 15.421 0.96967 15.2803C0.829018 15.1397 0.75 14.9489 0.75 14.75V4.25ZM9.75 6.5V8H14.25V6.5H9.75ZM13.5 9.5H9.75V11H13.5V9.5ZM7.875 8C7.875 7.50272 7.67746 7.02581 7.32583 6.67417C6.97419 6.32254 6.49728 6.125 6 6.125C5.50272 6.125 5.02581 6.32254 4.67417 6.67417C4.32254 7.02581 4.125 7.50272 4.125 8C4.125 8.49728 4.32254 8.97419 4.67417 9.32582C5.02581 9.67746 5.50272 9.875 6 9.875C6.49728 9.875 6.97419 9.67746 7.32583 9.32582C7.67746 8.97419 7.875 8.49728 7.875 8ZM6 10.625C5.30381 10.625 4.63613 10.9016 4.14384 11.3938C3.65156 11.8861 3.375 12.5538 3.375 13.25H8.625C8.625 12.5538 8.34844 11.8861 7.85616 11.3938C7.36387 10.9016 6.69619 10.625 6 10.625Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="text-white font-bold">
                  {user?.vehicles} VEÍCULOS
                </p>
              </div>
            </div>
            <div className="w-[12.9375rem]">
              <p className="text-xs text-zinc-500 font-bold">ANTECEDENTES C.</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0.75 4.25C0.75 4.05109 0.829018 3.86032 0.96967 3.71967C1.11032 3.57902 1.30109 3.5 1.5 3.5H16.5C16.6989 3.5 16.8897 3.57902 17.0303 3.71967C17.171 3.86032 17.25 4.05109 17.25 4.25V14.75C17.25 14.9489 17.171 15.1397 17.0303 15.2803C16.8897 15.421 16.6989 15.5 16.5 15.5H1.5C1.30109 15.5 1.11032 15.421 0.96967 15.2803C0.829018 15.1397 0.75 14.9489 0.75 14.75V4.25ZM9.75 6.5V8H14.25V6.5H9.75ZM13.5 9.5H9.75V11H13.5V9.5ZM7.875 8C7.875 7.50272 7.67746 7.02581 7.32583 6.67417C6.97419 6.32254 6.49728 6.125 6 6.125C5.50272 6.125 5.02581 6.32254 4.67417 6.67417C4.32254 7.02581 4.125 7.50272 4.125 8C4.125 8.49728 4.32254 8.97419 4.67417 9.32582C5.02581 9.67746 5.50272 9.875 6 9.875C6.49728 9.875 6.97419 9.67746 7.32583 9.32582C7.67746 8.97419 7.875 8.49728 7.875 8ZM6 10.625C5.30381 10.625 4.63613 10.9016 4.14384 11.3938C3.65156 11.8861 3.375 12.5538 3.375 13.25H8.625C8.625 12.5538 8.34844 11.8861 7.85616 11.3938C7.36387 10.9016 6.69619 10.625 6 10.625Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="text-white font-bold">
                  {user?.passages.length} PASSAGENS
                </p>
              </div>
            </div>
            <div>
              <p className="text-xs text-zinc-500 font-bold">PORTE DE ARMAS</p>
              <div className="flex items-center gap-2">
                <svg
                  width="18"
                  height="19"
                  viewBox="0 0 18 19"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0.75 4.25C0.75 4.05109 0.829018 3.86032 0.96967 3.71967C1.11032 3.57902 1.30109 3.5 1.5 3.5H16.5C16.6989 3.5 16.8897 3.57902 17.0303 3.71967C17.171 3.86032 17.25 4.05109 17.25 4.25V14.75C17.25 14.9489 17.171 15.1397 17.0303 15.2803C16.8897 15.421 16.6989 15.5 16.5 15.5H1.5C1.30109 15.5 1.11032 15.421 0.96967 15.2803C0.829018 15.1397 0.75 14.9489 0.75 14.75V4.25ZM9.75 6.5V8H14.25V6.5H9.75ZM13.5 9.5H9.75V11H13.5V9.5ZM7.875 8C7.875 7.50272 7.67746 7.02581 7.32583 6.67417C6.97419 6.32254 6.49728 6.125 6 6.125C5.50272 6.125 5.02581 6.32254 4.67417 6.67417C4.32254 7.02581 4.125 7.50272 4.125 8C4.125 8.49728 4.32254 8.97419 4.67417 9.32582C5.02581 9.67746 5.50272 9.875 6 9.875C6.49728 9.875 6.97419 9.67746 7.32583 9.32582C7.67746 8.97419 7.875 8.49728 7.875 8ZM6 10.625C5.30381 10.625 4.63613 10.9016 4.14384 11.3938C3.65156 11.8861 3.375 12.5538 3.375 13.25H8.625C8.625 12.5538 8.34844 11.8861 7.85616 11.3938C7.36387 10.9016 6.69619 10.625 6 10.625Z"
                    fill="white"
                    fillOpacity="0.25"
                  />
                </svg>
                <p className="text-white font-bold">
                  {user?.gunLicense ? 'Possui' : 'Não possui'}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="w-[53.875rem] h-[21.125rem] rounded bg-white bg-opacity-[1%] mt-4 p-4">
        <div className="w-[51.875rem] h-[1.5rem] rounded bg-white bg-opacity-[3%] flex items-center px-5">
          <p className="text-[0.625rem] text-[#54545D] w-[26.6875rem]">
            PASSAGEM
          </p>
          <p className="text-[0.625rem] text-[#54545D] w-[11.5rem]">OFICIAL</p>
          <p className="text-[0.625rem] text-[#54545D]">DATA</p>
        </div>
        <div className="flex flex-col mt-2.5 gap-3 overflow-x-hidden h-[17rem] overflow-y-auto w-[101%]">
          {user?.passages.map((passage, index) => {
            return (
              <div
                key={index}
                className="w-[51.875rem] flex-none h-[2.375rem] bg-white bg-opacity-[2%] rounded px-5 flex items-center"
              >
                <p className="text-[0.625rem] text-white font-bold w-[26.6875rem]">
                  {passage.description}
                </p>
                <p className="text-[0.625rem] text-white font-bold w-[11.5rem]">
                  {passage.officer}
                </p>
                <p className="text-[0.625rem] text-white font-bold">
                  {dayjs(passage.date * 1000).format('DD/MM/YYYY - HH:mm')}
                </p>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}
