import clsx from "clsx";
import { useData } from "../hooks/useData";

import Heart from "/icons/heart.svg"
import Shield from "/icons/shield.svg"

export function PlayerStats2() {
  const { data } = useData();

  return (
    <div className="flex items-center gap-[.38rem] right-8 bottom-6 animate-fade-in">
      <div className="flex items-center gap-1">
        <div className="w-10 h-[1.3125rem] flex items-center justify-center bg-primary rounded-[0.0625rem]">
          <img src={Heart} alt="heart" className="w-1/3"/>
        </div>
        <div className="flex items-center gap-[.12rem]">
          {Array.from({ length: 17 }).fill(0).map((_, index) => (
            <div key={index} className={clsx('w-[0.4375rem] h-[1.3125rem] rounded-[1px] transition-all border border-transparent', data.health >= (100 / 17) * (index + 1) ? 'bg-primary' : 'bg-black-500/70')} />
          ))}
        </div>
      </div>
      <div className="w-[3.125rem] h-[1.3125rem] bg-black-500/70 rounded-[0.0625rem] relative overflow-hidden">
        <img src={Shield} alt="shield" className="w-1/3 absolute left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2" />
        <div className="h-full w-full bg-gradient-to-r from-[#8D42F5] to-[#6F24D8] border-[.0625rem] border-[#8D42F5]" style={{ width: `${data.armour}%` }}></div>
      </div>
    </div>
  );
}
