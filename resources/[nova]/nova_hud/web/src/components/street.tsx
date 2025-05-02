import { useData } from '../hooks/useData'
import Loc from '/icons/loc.svg'

export default function Street() {
  const { data } = useData()

  return (
    <div className='flex items-center gap-[.31rem] absolute bottom-6'>
      <div className='size-9 bg-primary rounded-full grid place-items-center'>
        <img src={Loc} />
      </div>
      <p className='text-white/90 text-xs font-bold'>{ data.street }</p>
    </div>
  )
}