import { emit } from '@/utils/emit'
import { SearchIcon, X } from 'lucide-react'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'

export default function SearchArrest() {
  const [passport, setPassport] = useState(0)
  const navigate = useNavigate()

  function handleSearch() {
    if (!passport) return

    emit('searchPassport', { id: passport }).then((data) => {
      if (data) {
        navigate(`/arrest?id=${passport}`)
      }
    })
  }

  return (
    <div className="w-[55.875rem] h-[35.625rem] rounded bg-black/25 flex items-center justify-center">
      <div className="w-[28.125rem] h-[10.625rem] muted-foreground p-4">
        <div className="flex items-center gap-3">
          <div className="w-[29.625rem] h-[2.125rem] foreground grid place-items-center">
            <p className="text-sm font-bold text-white/20">EFETUAR PRISÃO</p>
          </div>
          <div className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center cursor-pointer">
            <X className="w-4 text-zinc-700" />
          </div>
        </div>
        <div className="px-2.5 flex items-center foreground w-full h-10 mt-2.5">
          <SearchIcon className="w-4 text-white/20" />
          <input
            onChange={(e) => setPassport(Number(e.target.value))}
            type="text"
            placeholder="ID"
            className="ml-2 w-full bg-transparent outline-none placeholder:text-white text-white text-sm"
          />
        </div>
        <button
          onClick={handleSearch}
          className="text-white text-sm w-[26.125rem] h-[2.625rem] font-bold bg-[#0066FF] rounded mt-3"
        >
          VERIFICAR
        </button>
      </div>
    </div>
  )
}
