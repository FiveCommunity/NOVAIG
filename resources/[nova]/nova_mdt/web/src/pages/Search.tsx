import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { emit } from '@/utils/emit'
import { SearchIcon, X } from 'lucide-react'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'

export default function Search() {
  const [passport, setPassport] = useState<number | null>(null)
  const [plate, setPlate] = useState<string>('')
  const [vehiclesSearch, setVehiclesSearch] = useState<string[]>([])
  const navigate = useNavigate()

  function handleSearchPassport() {
    if (!passport) return

    emit('searchPassport', { id: passport }).then((data) => {
      if (data) {
        navigate(`/user?id=${passport}`)
      }
    })
  }

  function handleSearchPlate() {
    if (!plate) return

    emit('searchPlate', { plate }, ['t20']).then((data) => {
      if (!data) return
      if (Array.isArray(data)) setVehiclesSearch(data)
    })
  }

  function handleChoiceVehicle(vehicle: string) {
    navigate(`/vehicle?plate=${plate}&vehicle=${vehicle}`)
  }

  return (
    <div className="flex items-center flex-col gap-16 w-[55.875rem] h-[35.625rem] justify-center">
      <div className="w-[28.125rem] h-[10.625rem] muted-foreground p-4">
        <div className="flex items-center gap-3">
          <div className="w-[23.5rem] h-[2.125rem] foreground grid place-items-center">
            <p className="text-sm font-bold text-white/20">CONSULTAR CIDADÃO</p>
          </div>
          <div className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center">
            <X className="w-4 text-zinc-700" />
          </div>
        </div>
        <div className="flex w-[26.125rem] h-[2.625rem] foreground mt-2.5 p-2.5 gap-2">
          <SearchIcon className="w-4 text-zinc-500" />
          <input
            onChange={(e) => setPassport(Number(e.target.value))}
            type="number"
            placeholder="ID"
            className="text-sm text-white bg-transparent w-full pr-2 placeholder:text-white outline-none"
          />
        </div>
        <button
          onClick={handleSearchPassport}
          className="w-[26.125rem] h-[2.625rem] bg-[#0066FF] text-white font-bold rounded mt-3"
        >
          REALIZAR CONSULTA
        </button>
      </div>
      <div className="w-[28.125rem] muted-foreground p-4">
        <div className="flex items-center gap-3">
          <div className="w-[23.5rem] h-[2.125rem] foreground grid place-items-center">
            <p className="text-sm font-bold text-white/20">CONSULTAR VEÍCULO</p>
          </div>
          <div className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center">
            <X className="w-4 text-zinc-700" />
          </div>
        </div>
        <div className="flex w-[26.125rem] h-[2.625rem] foreground mt-2.5 p-2.5 gap-2">
          <SearchIcon className="w-4 text-zinc-500" />
          <input
            onChange={(e) => setPlate(e.target.value)}
            type="text"
            placeholder="PLACA"
            className="text-sm text-white bg-transparent w-full pr-2 placeholder:text-white/20 outline-none"
          />
        </div>
        {vehiclesSearch.length > 0 && (
          <Select onValueChange={(e) => handleChoiceVehicle(e)}>
            <SelectTrigger>
              <SelectValue></SelectValue>
            </SelectTrigger>
            <SelectContent>
              {vehiclesSearch.map((vehicle, index) => (
                <SelectItem key={index} value={vehicle}>
                  {vehicle}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        )}
        <button
          onClick={handleSearchPlate}
          className="w-[26.125rem] h-[2.625rem] bg-[#0066FF] text-white font-bold rounded mt-3"
        >
          REALIZAR CONSULTA
        </button>
      </div>
    </div>
  )
}
