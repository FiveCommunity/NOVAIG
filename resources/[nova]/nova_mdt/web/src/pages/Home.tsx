import ContractModal from '@/components/contract-modal'
import { emit } from '@/utils/emit'
import clsx from 'clsx'
import dayjs from 'dayjs'
import { Clock, Menu, User } from 'lucide-react'
import { useEffect, useState, useRef, useMemo } from 'react'

interface IMemberProps {
  id: number
  name: string
  role: {
    tier: number
    name: string
  }
  online: boolean
  lastLogin: number
}

export default function Home() {
  const [selectedMember, setSelectedMember] = useState<number | null>(null)
  const [membersOnline, setMembersOnline] = useState<number>(0)
  const [members, setMembers] = useState<IMemberProps[]>([])
  const [showModal, setShowModal] = useState(false)
  const [search, setSearch] = useState('')
  const popoverRef = useRef<HTMLDivElement | null>(null)

  useEffect(() => {
    emit(
      'getInitialInfos',
      {},
      {
        membersOnline: 25,
        members: [
          {
            id: 231,
            name: 'Maka da Silva',
            online: true,
            role: {
              name: 'Chefe de Policia',
              tier: 1,
            },
            lastLogin: 1720920864,
          },
        ],
      },
    ).then((data) => {
      setMembersOnline(data.membersOnline)
      setMembers(data.members)
    })
  }, [])

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (
        popoverRef.current &&
        !popoverRef.current.contains(event.target as Node)
      ) {
        setSelectedMember(null)
      }
    }

    if (selectedMember !== null) {
      document.addEventListener('mousedown', handleClickOutside)
    } else {
      document.removeEventListener('mousedown', handleClickOutside)
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [selectedMember])

  const membersFiltered = useMemo(() => {
    return members.filter(
      ({ id, name, role }) =>
        String(id).includes(search) ||
        String(name).toLowerCase().includes(search.toLowerCase()) ||
        String(role.name).toLowerCase().includes(search.toLowerCase()),
    )
  }, [search, members])

  return (
    <div>
      <div className="w-[55.875rem] h-[5.125rem] muted-foreground py-6 px-6 flex items-center justify-between">
        <div>
          <p className="font-bold text-[#6D6D75] leading-3">
            SISTEMA POLICIAL DO ESTADO DE
          </p>
          <p className="text-white font-bold">LOTUS ROLEPLAY</p>
        </div>

        <button
          onClick={() => setShowModal(true)}
          className="w-[10.5rem] h-10 foreground hover:bg-[#0066FF] text-lg font-bold text-white"
        >
          CONTRATAR
        </button>

        <div className="flex items-center gap-4">
          <div className="">
            <p className="text-xs text-[#6D6D75] font-bold leading-3">
              OFICIAIS EM ATIVIDADE
            </p>
            <p className="text-xl text-white font-bold text-right">
              {membersOnline ?? 0}/{members.length}
            </p>
          </div>
          <div className="w-[3.25rem] h-[3.25rem] foreground grid place-items-center !rounded-full">
            <User className="w-6 text-white/50" />
          </div>
        </div>
      </div>
      <div className="w-[55.875rem] h-[29.5rem] muted-foreground p-4 mt-4">
        <div className="flex items-center gap-2.5">
          <div className="w-[42.75rem] h-[1.5rem] foreground flex items-center px-5">
            <p className="text-[#54545D] text-[.625rem] w-[8.25rem] font-semibold">
              PASSAPORTE
            </p>
            <p className="text-[#54545D] text-[.625rem] w-[12.1rem] font-semibold">
              NOME
            </p>
            <div className="flex items-center gap-1.5 w-[12.8125rem]">
              <p className="text-[#54545D] text-[.625rem] font-semibold">
                Cargo
              </p>
              <svg
                className="cursor-pointer"
                width="12"
                height="12"
                viewBox="0 0 12 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fillRule="evenodd"
                  clipRule="evenodd"
                  d="M2 7.5L6 3.5L10 7.5L9 8.5L6 5.5L3 8.5L2 7.5Z"
                  fill="#54545D"
                />
              </svg>
            </div>
            <div className="flex items-center gap-1.5">
              <p className="text-[#54545D] text-[.625rem] font-semibold">
                ÚLTIMO LOGIN
              </p>
              <svg
                className="cursor-pointer"
                width="12"
                height="12"
                viewBox="0 0 12 12"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fillRule="evenodd"
                  clipRule="evenodd"
                  d="M2 7.5L6 3.5L10 7.5L9 8.5L6 5.5L3 8.5L2 7.5Z"
                  fill="#54545D"
                />
              </svg>
            </div>
          </div>
          <input
            type="text"
            onChange={(e) => setSearch(e.target.value)}
            className="w-[10.5rem] h-[1.5rem] foreground text-xs text-white placeholder:text-white p-3 focus:outline-none placeholder:text-white/20"
            placeholder="Pesquise um usuário"
          />
          {/*  */}
        </div>
        <div className="mt-2.5 flex flex-col gap-2 overflow-x-hidden h-[25rem] overflow-y-auto w-[101%]">
          {membersFiltered.map((member, i) => {
            return (
              <div
                key={i}
                className="w-[53.875rem] flex-none h-[2.375rem] foreground pl-[2.81rem] flex items-center relative"
              >
                <p className="text-white text-xs font-semibold truncate w-[5.0625rem]">
                  {member.id}
                </p>
                <p className="text-white text-xs font-semibold truncate w-[12.5rem]">
                  {member.name}
                </p>
                <div className="flex items-center gap-2 w-[13.125rem]">
                  <p className="text-white text-xs font-semibold truncate">
                    {member.role.name}
                  </p>
                </div>
                <div className="flex items-center gap-2 w-[16rem]">
                  <p className="text-white text-xs font-semibold truncate">
                    {dayjs(member.lastLogin * 1000).format(
                      'DD/MM/YYYY - HH:mm',
                    )}
                  </p>
                  <Clock className="w-4 text-[#54545E]" />
                </div>
                <div className="flex items-center gap-4">
                  <div
                    className={clsx(
                      'w-[0.625rem] h-[0.625rem] rounded bg-green-400',
                      {
                        'bg-red-600': !member.online,
                      },
                    )}
                  />
                  <div
                    onClick={() => setSelectedMember(i)}
                    className="w-[1.75rem] h-[1.375rem] foreground grid place-items-center cursor-pointer"
                  >
                    <Menu className="w-4 text-white/50" />
                  </div>
                </div>
                {selectedMember === i && (
                  <div
                    ref={popoverRef}
                    onClick={() => setSelectedMember(null)}
                    className="flex flex-col p-3 rounded z-20 !bg-opacity-0 !border-white/20 muted-foreground absolute right-6 top-6"
                  >
                    <p
                      onClick={() => emit('promote', { id: member.id })}
                      className="text-white text-xs font-bold p-1.5 hover:bg-white/5 cursor-pointer rounded"
                    >
                      PROMOVER MEMBRO
                    </p>
                    <p
                      onClick={() => emit('demote', { id: member.id })}
                      className="text-white text-xs font-bold p-1.5 hover:bg-white/5 cursor-pointer rounded"
                    >
                      REBAIXAR MEMBRO
                    </p>
                    <p
                      onClick={() => emit('dismiss', { id: member.id })}
                      className="text-white text-xs font-bold p-1.5 hover:bg-white/5 cursor-pointer rounded"
                    >
                      DEMITIR MEMBRO
                    </p>
                  </div>
                )}
              </div>
            )
          })}
        </div>
      </div>
      {showModal && <ContractModal setShowModal={setShowModal} />}
    </div>
  )
}
