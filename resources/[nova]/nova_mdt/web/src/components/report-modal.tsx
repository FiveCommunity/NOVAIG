import { X } from 'lucide-react'
import { useState } from 'react'
import { emit } from '@/utils/emit'

export default function ReportModal({
  setShowModal,
  RefreshReports,
}: {
  RefreshReports: () => void
  setShowModal: (value: boolean) => void
}) {
  const [officer, setOfficer] = useState<string>('')
  const [involved, setInvolved] = useState<number | null>(null)
  const [description, setDescription] = useState<string>('')

  function handleReport() {
    if (!officer || !involved || !description) return

    emit('createReport', {
      officer,
      involved,
      description,
    }).then(RefreshReports)

    setShowModal(false)
  }

  return (
    <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 transform w-[34.5rem] rounded muted-foreground p-4">
      <div className="flex items-center gap-3">
        <div className="w-[29.625rem] h-[2.125rem] foreground grid place-items-center">
          <p className="text-sm font-bold text-white/20 uppercase">
            criar novo boletim
          </p>
        </div>
        <div
          onClick={() => setShowModal(false)}
          className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center cursor-pointer"
        >
          <X className="w-4 text-zinc-700" />
        </div>
      </div>
      <div className="space-y-2 mt-3">
        <p className="text-sm text-[#7C7C8A] font-bold">OFICIAL</p>
        <input
          onChange={(e) => setOfficer(e.target.value)}
          type="text"
          className="w-full h-[2.625rem] foreground text-sm text-white placeholder:text-white p-3"
          placeholder="..."
        />
      </div>
      <div className="space-y-2 mt-3">
        <p className="text-sm text-[#7C7C8A] font-bold">ID DO ENVOLVIDO</p>
        <input
          onChange={(e) => setInvolved(Number(e.target.value))}
          type="number"
          className="w-full h-[2.625rem] foreground text-sm text-white placeholder:text-white p-3"
          placeholder="..."
        />
      </div>
      <div className="space-y-2 mt-3">
        <p className="text-sm text-[#7C7C8A] font-bold">
          DESCRIÇÃO DO OCORRIDO
        </p>
        <textarea
          onChange={(e) => setDescription(e.target.value)}
          className="w-full h-[14.375rem] resize-none foreground outline-none text-sm text-white placeholder:text-white p-3"
          placeholder="..."
        ></textarea>
      </div>
      <button
        onClick={handleReport}
        className="w-full h-[2.625rem] bg-[#0066FF] text-white font-bold rounded mt-3"
      >
        CRIAR NOVO BOLETIM
      </button>
    </div>
  )
}
