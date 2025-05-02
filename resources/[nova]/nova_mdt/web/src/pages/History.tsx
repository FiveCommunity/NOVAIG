import { emit } from '@/utils/emit'
import dayjs from 'dayjs'
import { SearchIcon } from 'lucide-react'
import { useEffect, useState } from 'react'

interface IHistoryProps {
  id: number
  name: string
  action: string
  date: number
}

export default function History() {
  const [history, setHistory] = useState<IHistoryProps[]>([])
  const [search, setSearch] = useState<string>('')

  useEffect(() => {
    emit<IHistoryProps[]>('getHistory', {}, [
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
      {
        id: 1,
        name: 'Maka da Silva',
        action: 'Prendeu Junior Duble',
        date: 1720920864,
      },
    ]).then(setHistory)
  }, [])

  const filteredHistory = history.filter((item) => {
    return item.name.toLowerCase().includes(search.toLowerCase())
  })

  return (
    <div className="w-[55.875rem] h-[35.625rem] rounded muted-foreground p-4">
      <div className="w-[53.875rem] h-[2.875rem] foreground px-5 flex items-center justify-between">
        <p className="text-[#54545D] text-[.625rem] w-[8.25rem] font-semibold">
          HISTÓRICO
        </p>
        <div className="w-[19.125rem] h-[1.875rem] rounded bg-white bg-opacity-[3%] px-3 flex items-center gap-3">
          <SearchIcon className="w-4 text-zinc-600" />
          <input
            onChange={(e) => setSearch(e.target.value)}
            className="w-full bg-transparent outline-none text-sm text-white placeholder:text-white/50"
            placeholder="Pesquisar"
            type="text"
          />
        </div>
      </div>
      <div className="w-[53.875rem] h-[1.5rem] foreground mt-2.5 px-5 flex items-center">
        <p className="w-[5.375rem] text-[.625rem] font-semibold text-[#54545D]">
          #
        </p>
        <p className="w-[15.3125rem] text-[.625rem] font-semibold text-[#54545D]">
          NOME
        </p>
        <p className="w-[17.3125rem] text-[.625rem] font-semibold text-[#54545D]">
          AÇÃO
        </p>
        <p className="w-[5.375rem] text-[.625rem] font-semibold text-[#54545D]">
          DATA
        </p>
      </div>
      <div className="mt-2.5 flex flex-col gap-3 h-[28rem] overflow-x-hidden overflow-y-auto w-[101%]">
        {filteredHistory.map((item, i) => (
          <div
            key={i}
            className="w-[53.875rem] flex-none h-[2.5rem] bg-white bg-opacity-[2%] px-5 flex items-center"
          >
            <p className="w-[5.375rem] text-[.625rem] text-white font-bold">
              {item.id}
            </p>
            <p className="w-[15.3125rem] text-[.625rem] text-white font-bold">
              {item.name}
            </p>
            <p className="w-[17.3125rem] text-[.625rem] text-white font-bold">
              {item.action}
            </p>
            <p className="w-[5.375rem] text-[.625rem] text-white font-bold">
              {dayjs(item.date).format('DD/MM/YYYY')}
            </p>
          </div>
        ))}
      </div>
    </div>
  )
}
