import dayjs from 'dayjs'
import { X } from 'lucide-react'

interface InsidentReportModalProps {
  id: number
  officer: string
  date: number
  involved: string
  description: string
  close: () => void
}

export default function InsidentReportModal({
  id,
  close,
  officer,
  date,
  involved,
  description,
}: InsidentReportModalProps) {
  return (
    <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 transform w-[34.5rem] rounded muted-foreground p-3 flex flex-col gap-3">
      <div className="w-full h-[2.625rem] flex items-center gap-3">
        <div className="flex-1 h-full rounded bg-white/[0.03] flex items-center justify-center text-center text-[#7C7C8A] font-extrabold text-sm leading-[normal]">
          Boletim #{id}{' '}
        </div>
        <div
          onClick={close}
          className="w-[2.625rem] h-full foreground grid place-items-center cursor-pointer flex-none"
        >
          <X className="w-4 text-zinc-700" />
        </div>
      </div>
      <div className="w-full flex flex-col gap-4">
        <div className="flex flex-col gap-2">
          <label className="text-[#7C7C8A] text-[.8125rem] leading-[normal] font-medium ml-3">
            Oficial responsável
          </label>
          <span className="bg-white/[0.02] rounded py-3 pl-3 text-white">
            {officer}
          </span>
        </div>
        <div className="flex flex-col gap-2">
          <label className="text-[#7C7C8A] text-[.8125rem] leading-[normal] font-medium ml-3">
            DATA E HORÁRIO
          </label>
          <span className="bg-white/[0.02] rounded py-3 pl-3 text-white">
            {dayjs(date * 1000).format('DD/MM/YYYY')}
          </span>
        </div>
        <div className="flex flex-col gap-2">
          <label className="text-[#7C7C8A] text-[.8125rem] leading-[normal] font-medium ml-3">
            ENVOLVIDO
          </label>
          <span className="bg-white/[0.02] rounded py-3 pl-3 text-white">
            {involved}
          </span>
        </div>
        <div className="flex flex-col gap-2">
          <label className="text-[#7C7C8A] text-[.8125rem] leading-[normal] font-medium ml-3">
            DESCRIÇÃO DO OCORRIDO
          </label>
          <span className="bg-white/[0.02] rounded py-3 pl-3 text-white/55 min-h-[8.625rem] text-[.875rem] leading-[17px]">
            {description}
          </span>
        </div>
      </div>
    </div>
  )
}
