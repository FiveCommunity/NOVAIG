import ArrestModal from '@/components/arrest-modal'
import { Checkbox } from '@/components/ui/checkbox'
import { useNui } from '@/store/useNui'
import { emit } from '@/utils/emit'
import { useEffect, useState } from 'react'
import { useSearchParams } from 'react-router-dom'

export default function Arrest() {
  const { userArrest, setUserArrest } = useNui()
  const [searchParams, _] = useSearchParams()
  const [showModal, setShowModal] = useState(false)

  useEffect(() => {
    emit(
      'getUserForArrest',
      { id: searchParams.get('id') },
      {
        name: 'Maka da Silva',
        image: 'https://i.pravatar.cc/150?u=231',
      },
    ).then((data: any) => {
      setUserArrest({
        name: data.name,
        image: data.image,
        bail: false,
        id: Number(searchParams.get('id')) || 0,
        accused: '',
        mounths: 0,
        totalFine: 0,
        totalBail: 0,
        crimes: [],
        mitigatingFactors: [],
      })
    })
  }, [])

  function handleCheckbox() {
    console.log('ola')
    setUserArrest({
      ...userArrest,
      bail: !userArrest.bail,
    })
  }

  return (
    <div className="w-[55.875rem] h-[35.625rem] muted-foreground p-4">
      <div className="w-[53.875rem] h-[7.375rem] foreground p-4 flex items-center">
        <img
          className="w-[5.375rem] h-[5.375rem] rounded bg-gray-300/50"
          src={userArrest.image}
          alt="avatar"
        />
        <div className="flex items-center">
          <div className="w-[9rem] ml-4">
            <p className="text-xs text-zinc-600 font-semibold">NOME</p>
            <div className="flex items-center gap-2">
              <p className="text-white font-bold">{userArrest.name}</p>
            </div>
          </div>
          <div className="w-[11.75rem]">
            <p className="text-xs text-zinc-600 font-semibold">PASSAPORTE</p>
            <div className="flex items-center gap-2">
              <p className="text-white font-bold">{userArrest.id}</p>
            </div>
          </div>
          <div className="flex items-center gap-2 w-[11.0625rem]">
            <Checkbox
              onClick={() => handleCheckbox()}
              className="w-[1.75rem] h-[1.75rem]"
            />
            <p className="text-sm text-white">Pagar fiança</p>
          </div>
          <button
            onClick={() => setShowModal(true)}
            className="foreground w-[10.5rem] h-[2.375rem] text-white font-bold text-sm"
          >
            CALCULAR PENA
          </button>
        </div>
      </div>
      <div className="w-[53.875rem] h-[19.625rem] bg-white bg-opacity-[2%] mt-[2rem] p-5 flex flex-wrap">
        <div className="w-[33%]">
          <p className="text-[#98989A] text-xs font-semibold">
            NOME DO ACUSADO
          </p>
          <p className="text-white font-bold">{userArrest.name}</p>
        </div>
        <div className="w-[33%]">
          <p className="text-[#98989A] text-xs font-semibold">ID DO ACUSADO</p>
          <p className="text-white font-bold">{userArrest.id}</p>
        </div>
        <div>
          <p className="text-[#98989A] text-xs font-semibold">TOTAL DA PENA</p>
          <p className="text-white font-bold">
            {userArrest.mounths -
              userArrest.mitigatingFactors.reduce(
                (acc, curr) => acc + curr.mounths,
                0,
              )}
          </p>
        </div>
        <div className="w-[33%]">
          <p className="text-[#98989A] text-xs font-semibold">TOTAL DE MULTA</p>
          <p className="text-white font-bold">
            {userArrest.totalFine.toLocaleString('pt-br', {
              style: 'currency',
              currency: 'BRL',
              minimumFractionDigits: 0,
              maximumFractionDigits: 0,
            })}
          </p>
        </div>
        <div className="w-[33%]">
          <p className="text-[#98989A] text-xs font-semibold">
            VALOR TOTAL DA FIANÇA
          </p>
          <p className="text-white font-bold">
            {' '}
            {userArrest.totalBail.toLocaleString('pt-br', {
              style: 'currency',
              currency: 'BRL',
              minimumFractionDigits: 0,
              maximumFractionDigits: 0,
            })}
          </p>
        </div>
        <div className="w-[33%]">
          <p className="text-[#98989A] text-xs font-semibold">
            CRIMES COMETIDOS
          </p>
          <p className="text-white font-bold">
            {userArrest.crimes.map((crime) => crime.name).join(', ') ||
              'Nenhum'}
          </p>
        </div>
        <div className="w-[33%]">
          <p className="text-[#98989A] text-xs font-semibold">FIANÇA PAGA</p>
          <p className="text-white font-bold">
            {userArrest.bail ? 'SIM' : 'NÃO'}
          </p>
        </div>
        <div className="w-[33%]">
          <p className="text-[#98989A] text-xs font-semibold">ATENUANTES</p>
          <p className="text-white font-bold">
            {userArrest.mitigatingFactors
              .map((mitigatingFactor) => mitigatingFactor.name)
              .join(', ') || 'Nenhum'}
          </p>
        </div>
      </div>
      <button
        onClick={() => emit('arrest', { userArrest })}
        className="w-full h-[2.625rem] bg-[#0066FF] mt-4 rounded text-white font-bold"
      >
        REALIZAR PRISÃO
      </button>
      {showModal && <ArrestModal setShowModal={setShowModal} />}
    </div>
  )
}
