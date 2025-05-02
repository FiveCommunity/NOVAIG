import { ICrimes, IMitigatingFactors, useNui } from '@/store/useNui'
import clsx from 'clsx'
import { SearchIcon, X } from 'lucide-react'
import { useState } from 'react'

interface Props {
  setShowModal: (value: boolean) => void
}

export default function ArrestModal({ setShowModal }: Props) {
  const { userArrest, setUserArrest, crimes, mitigatingFactors } = useNui()
  const [searchCrimes, setSearchCrimes] = useState<string>('')
  const [searchMitigatingFactors, setSearchMitigatingFactors] =
    useState<string>('')

  function handleCrimes(crime: ICrimes) {
    const newCrimes = userArrest.crimes
    const index = newCrimes.findIndex((c) => c.name === crime.name)

    if (index === -1) {
      newCrimes.push(crime)
    } else {
      newCrimes.splice(index, 1)
    }

    setUserArrest({
      ...userArrest,
      mounths: newCrimes.reduce((acc, curr) => acc + curr.mounths, 0),
      totalFine: newCrimes.reduce((acc, curr) => acc + curr.fine, 0),
      crimes: newCrimes,
    })
  }

  function handleMitigatingFactors(mitigatingFactor: IMitigatingFactors) {
    const newMitigatingFactors = userArrest.mitigatingFactors
    const index = newMitigatingFactors.findIndex(
      (c) => c.name === mitigatingFactor.name,
    )

    if (index === -1) {
      newMitigatingFactors.push(mitigatingFactor)
    } else {
      newMitigatingFactors.splice(index, 1)
    }

    setUserArrest({
      ...userArrest,
      totalBail: newMitigatingFactors.reduce(
        (acc, curr) => acc + curr.mounths,
        0,
      ),
      totalFine: newMitigatingFactors.reduce((acc, curr) => acc + curr.fine, 0),
      mitigatingFactors: newMitigatingFactors,
    })
  }

  const filteredCrimes = crimes.filter((crime) => {
    return crime.name.toLowerCase().includes(searchCrimes.toLowerCase())
  })

  const filteredMitigatingFactors = mitigatingFactors.filter(
    (mitigatingFactor) => {
      return mitigatingFactor.name
        .toLowerCase()
        .includes(searchMitigatingFactors.toLowerCase())
    },
  )

  return (
    <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 transform p-4 bg-[#15151A] w-[45rem] max-h-[47.25rem] rounded">
      <div className="flex items-center gap-2">
        <div className="w-full h-[2.125rem] bg-white bg-opacity-[3%] rounded text-white/50 font-bold text-center flex items-center justify-center text-sm">
          CALCULAR PENA
        </div>
        <div
          onClick={() => setShowModal(false)}
          className="w-[2.125rem] h-[2.125rem] foreground grid place-items-center cursor-pointer"
        >
          <X className="w-4 text-zinc-700" />
        </div>
      </div>
      <div className="flex items-center gap-4 mt-6">
        <div className="flex flex-col gap-1">
          <label className="text-sm text-zinc-600 font-semibold" htmlFor="">
            Nome
          </label>
          <div className="rounded w-[21rem] h-[3rem] bg-white bg-opacity-[2%] flex items-center px-3">
            <p className="text-white text-sm">{userArrest.name}</p>
          </div>
        </div>
        <div className="flex flex-col gap-1">
          <label className="text-sm text-zinc-600 font-semibold" htmlFor="">
            Passaporte
          </label>
          <div className="rounded w-[21rem] h-[3rem] bg-white bg-opacity-[2%] flex items-center px-3">
            <p className="text-white text-sm">{userArrest.id}</p>
          </div>{' '}
        </div>
      </div>
      <div className="mt-6 space-y-1">
        <label className="text-sm text-zinc-600 font-semibold" htmlFor="">
          Crimes
        </label>
        <div className="w-[43rem] h-[2.375rem] bg-white bg-opacity-[2%] rounded px-3 flex items-center gap-3">
          <SearchIcon className="w-4 text-zinc-600" />
          <input
            className="w-full bg-transparent outline-none text-sm text-white placeholder:text-white/50"
            placeholder="Pesquisar crime"
            onChange={(e) => setSearchCrimes(e.target.value)}
            type="text"
          />
        </div>
        <div
          className="grid grid-cols-2 gap-3 max-h-[12.75rem] overflow-hidden overflow-y-auto"
          style={{ marginTop: '.75rem' }}
        >
          {filteredCrimes.map((crime, i) => (
            <div
              onClick={() => handleCrimes(crime)}
              key={i}
              className={clsx(
                'w-[21.125rem] h-[2.625rem] border border-white/5 rounded flex items-center justify-center cursor-pointer px-3',
                {
                  'bg-[#0066FF]': userArrest.crimes.includes(crime),
                },
              )}
            >
              <p className="text-white text-sm">{crime.name}</p>
            </div>
          ))}
        </div>
      </div>
      <div className="mt-6 space-y-1">
        <label className="text-sm text-zinc-600 font-semibold" htmlFor="">
          Atenuantes
        </label>
        <div className="w-[43rem] h-[2.375rem] bg-white bg-opacity-[2%] rounded px-3 flex items-center gap-3">
          <SearchIcon className="w-4 text-zinc-600" />
          <input
            onChange={(e) => setSearchMitigatingFactors(e.target.value)}
            className="w-full bg-transparent outline-none text-sm text-white placeholder:text-white/50"
            placeholder="Pesquisar atenuante"
            type="text"
          />
        </div>
        <div
          className="grid grid-cols-1 gap-3 max-h-[10.75rem] overflow-hidden overflow-y-auto"
          style={{ marginTop: '.75rem' }}
        >
          {filteredMitigatingFactors.map((mitigatingFactor, i) => (
            <div
              onClick={() => handleMitigatingFactors(mitigatingFactor)}
              key={i}
              className={clsx(
                'w-full h-[2.625rem] border border-white/5 rounded flex items-center justify-center cursor-pointer px-3',
                {
                  'bg-[#0066FF]':
                    userArrest.mitigatingFactors.includes(mitigatingFactor),
                },
              )}
            >
              <p className="text-white text-sm">{mitigatingFactor.name}</p>
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
