import clsx from "clsx";
import { MdOutlineStar } from "react-icons/md";

import Engine from '/icons/engine.svg'

interface VehicleProps {
  name: string;
  image_url: string;
  category: string;
  selected: boolean;
  favorited: boolean;
  onFavorite: () => void;
  onSelect: () => void;
  engine: number
}

export function Vehicle({ engine, image_url, name, category, favorited, selected, onFavorite, onSelect }: VehicleProps) {
  return (
    <div className={clsx(selected && "!bg-gradient-to-b from-[#D3132F00] to-[#FE38003b]", "w-[18.125rem] h-[9.0625rem] flex-none flex flex-col items-center justify-between p-[.62rem] rounded-[0.1875rem] relative")} style={{ boxShadow: 'inset 0 0 0 .0625rem rgb(255, 255, 255, .13)', background: 'radial-gradient(79.03% 79.03% at 50% 20.97%, rgba(255, 255, 255, 0.09) 0%, rgba(153, 153, 153, 0.02) 100%)' }}>
      <MdOutlineStar onClick={onFavorite} className={`${favorited ? 'text-primary' : 'text-white/30'} size-5 group-hover:text-white cursor-pointer absolute top-[.62rem] right-[.62rem]`}/>
      <div className="flex items-center gap-[.94rem]">
        <img src={image_url || ''} draggable={false} onError={(e) => e.currentTarget.src = '/images/default_vehicle.webp'} className="w-[8.875rem] h-[4.5625rem]"/>
        <div>
          <h3 className="text-white text-[0.9375rem] font-bold truncate w-[6.3125rem]">{ name }</h3>
          <p className="text-white/80 text-[0.6875rem] font-medium">{ category }</p>
        </div>
      </div>
      <div className="flex items-center gap-[.44rem] w-full h-[2.0625rem]">
        <div className="w-[3.75rem] h-full rounded-sm border-[.05rem] border-white/15 bg-white/[.13] flex items-center justify-center gap-[.31rem]">
          <img src={Engine} className="w-[0.8125rem]" />
          <p className="text-white text-[0.6875rem] font-extrabold">{ engine }%</p>
        </div>
        <button onClick={onSelect} className={clsx(selected && "!bg-primary !text-white shadow-primary !border-primary", "flex-1 h-full rounded-sm border-[.05rem] border-white/15 bg-white/[.13] text-white/80 text-[0.6875rem] font-extrabold uppercase")}>{selected ? 'SELECIONADO' : 'SELECIONAR'}</button>
      </div>
    </div>
  )
}