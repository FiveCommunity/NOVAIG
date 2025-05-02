import RolesModal from '@/components/roles-modal'
import { useNui } from '@/store/useNui'
import { emit } from '@/utils/emit'
import { useEffect, useState } from 'react'

export type PermissionsT =
  | 'canHire'
  | 'canPromote'
  | 'canDemote'
  | 'canDismiss'

export interface IPermission {
  name: string;
  permission: PermissionsT
}

export interface IRole {
  name: string
  members: number
  permissions: PermissionsT[]
}

export default function Config() {
  const [roles, setRoles] = useState<IRole[]>([])
  const [selectedRole, setSelectedRole] = useState<IRole | null>(null)
  const [showModal, setShowModal] = useState<boolean>(false)
  const { org } = useNui()

  useEffect(() => {
    emit<IRole[]>('getRoles', {}, [
      {
        name: 'Líder',
        members: 20,
        permissions: [
          'canHire',
          'canPromote',
          'canDemote',
          'canDismiss',
        ]
      },
    ]).then((data) => setRoles(data))
  }, [])

  function handleRole(role: IRole) {
    setSelectedRole(role)
    setShowModal(true)
  }

  return (
    <div className="w-[55.875rem] h-[35.625rem] muted-foreground p-4 px-2.5 rounded">
      <div className="w-[53.875rem] h-[7.375rem] rounded gap-4 flex items-center bg-white bg-opacity-[1%] py-[1.38rem] px-[2.63rem]">
        <img src={''} className="w-[5.625rem] h-[4.625rem]" alt="" />
        <div>
          <p className="text-sm text-white/40 font-semibold">URL DA IMAGEM</p>
          <input
            type="text"
            className="w-[30rem] outline-none text-white px-4 h-[2.375rem] foreground rounded mt-3"
            placeholder={org?.icon || '...'}
          />
        </div>
        <button className="w-[10.5rem] text-white font-bold mt-8 h-[2.375rem] rounded foreground ml-3">
          ALTERAR
        </button>
      </div>
      <div className="flex items-center gap-2.5">
        <div className="w-full h-[1.5rem] foreground mt-3 px-5 flex items-center">
          <p className="text-[.625rem] font-semibold text-[#54545D] w-[4.0625rem]">
            #
          </p>
          <p className="text-[.625rem] font-semibold text-[#54545D] w-[12.125rem]">
            NOME
          </p>
          <p className="text-[.625rem] font-semibold text-[#54545D] w-[14.4375rem]">
            MEMBROS NO CARGO
          </p>
          <p className="text-[.625rem] font-semibold text-[#54545D]">
            PERMISSÕES
          </p>
        </div>
      </div>
      <div className="flex flex-col gap-3 mt-3 h-[22rem] overflow-y-auto overflow-x-hidden">
        {roles.map((role, index) => (
          <div
            key={index}
            className="w-full flex-none h-[3.25rem] relative bg-white bg-opacity-[1%] rounded px-5 flex items-center"
          >
            <p className="text-[.625rem] text-white w-[4.0625rem]">
              {index + 1}
            </p>
            <p className="text-[.625rem] text-white w-[15.125rem]">
              {role.name}
            </p>
            <p className="text-[.625rem] text-white w-[9.4375rem]">
              {role.members}
            </p>
            <div
              onClick={() => handleRole(role)}
              className="text-[.625rem] grid place-items-center cursor-pointer text-white w-[8rem] h-[1.375rem] rounded bg-white/5"
            >
              VER PERMISSÕES
            </div>
          </div>
        ))}
      </div>
      {showModal && (
        <RolesModal setShowModal={setShowModal} role={selectedRole!} />
      )}
    </div>
  )
}
