import { X } from 'lucide-react'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from './ui/select'
import { useEffect, useState } from 'react'
import { emit } from '@/utils/emit'

export default function ContractModal({
  setShowModal,
}: {
  setShowModal: (value: boolean) => void
}) {
  const [role, setRole] = useState<string>('Membro')
  const [roles, setRoles] = useState<string[]>(['Membro', 'Gerente', 'Lider'])
  const [passport, setPassport] = useState<number | null>(null)

  function handleContract() {
    if (!passport) return

    emit('contractMember', {
      passport,
      role,
    })

    setShowModal(false)
  }

  useEffect(() => {
    emit('getRolesToContract').then((data: string[]) => {
      setRoles(data)
    })
  }, [])

  return (
    <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 transform w-[28.125rem] h-[14rem] rounded muted-foreground p-4">
      <div className="flex items-center gap-3">
        <div className="w-[23.5rem] h-[2.125rem] foreground grid place-items-center">
          <p className="text-sm font-bold text-white/20">CONTRATAR MEMBRO</p>
        </div>
        <div
          onClick={() => setShowModal(false)}
          className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center"
        >
          <X className="w-4 text-zinc-700" />
        </div>
      </div>
      <input
        onChange={(e) => setPassport(Number(e.target.value))}
        type="number"
        className="w-[26.125rem] h-[2.625rem] foreground mt-2.5 text-sm text-white placeholder:text-white p-3"
        placeholder="ID"
      />
      <Select onValueChange={(e) => setRole(e)}>
        <SelectTrigger>
          <SelectValue></SelectValue>
        </SelectTrigger>
        <SelectContent>
          {roles.map((role, i) => (
            <SelectItem key={i} value={role}>
              {role}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
      <button
        onClick={handleContract}
        className="w-[26.125rem] h-[2.625rem] bg-[#0066FF] text-white font-bold rounded mt-3"
      >
        REALIZAR CONTRATAÇÃO
      </button>
    </div>
  )
}
