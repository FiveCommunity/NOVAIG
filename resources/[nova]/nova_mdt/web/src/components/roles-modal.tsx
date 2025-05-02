import { IRole, PermissionsT } from '@/pages/Config'
import { X } from 'lucide-react'
import { Checkbox } from './ui/checkbox'
import { useState } from 'react'
import { emit } from '@/utils/emit'

export default function RolesModal({
  role,
  setShowModal,
}: {
  role: IRole
  setShowModal: (value: boolean) => void
}) {
  const [editRole, setEditRole] = useState<IRole>(role)
  const permissionsList = {
    canHire: 'CONTRATAR',
    canPromote: 'PROMOVER',
    canDemote: 'REBAIXAR',
    canDismiss: 'DEMITIR',
  } as { [permission in PermissionsT]: string }

  function handleRole(permission: PermissionsT) {
    if (editRole.permissions.includes(permission)) {
      setEditRole({
        ...editRole,
        permissions: editRole.permissions.filter((perm) => perm !== permission),
      })
    } else {
      setEditRole({
        ...editRole,
        permissions: [...editRole.permissions, permission],
      })
    }
  }

  function handleSave() {
    emit('editRole', {
      role: editRole,
    })
    setShowModal(false)
  }

  return (
    <div className="w-[34.5rem] h-[22.5rem] bg-[#15151A] rounded p-3 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 transform">
      <div className="flex items-center gap-3">
        <div className="w-full h-[2.125rem] foreground grid place-items-center">
          <p className="text-sm font-bold text-white/20">ALTERAR CARGO</p>
        </div>
        <div
          onClick={() => setShowModal(false)}
          className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center"
        >
          <X className="w-4 text-zinc-700" />
        </div>
      </div>
      <div className="mt-4 space-y-1">
        <p className="text-sm text-[#7C7C8A]">NOME DO CARGO</p>
        <div className="w-[33rem] h-[2.625rem] rounded px-3 text-sm text-white flex items-center foreground outline-none">
          <p>{role.name}</p>
        </div>
      </div>
      <div className="mt-4 space-y-1">
        <p className="text-sm text-[#7C7C8A]">PERMISSÕES</p>
        <div className="grid grid-cols-4 gap-4">
          {Object.entries(permissionsList).map(([permission, name]) => {
            return (
              <div key={name} className="flex gap-2 items-center">
                <Checkbox
                  onClick={() => handleRole(permission as PermissionsT)}
                  checked={editRole.permissions.includes(
                    permission as PermissionsT,
                  )}
                />
                <p className="text-sm text-white">{name}</p>
              </div>
            )
          })}
        </div>
      </div>
      <button
        className="w-full h-[2.625rem] bg-[#0066FF] text-white font-bold mt-4 rounded"
        onClick={handleSave}
      >
        SALVAR CARGO
      </button>
    </div>
  )
}
