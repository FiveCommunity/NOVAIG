import Light from "/icons/light.svg";
import Lock from "/icons/lock.svg";
import March from "/icons/march.svg";
import Seatbelt from "/icons/seatbelt.svg";
import Nitro from "/icons/nitro.svg";
import Engine from "/icons/engine.svg";

import { useData } from "../hooks/useData";
import clsx from "clsx";

export function Velocimeter() {
  const { data } = useData(); 

  return data.vehicle?.data && (
    <div className={clsx("w-[15.6875rem] h-[4.625rem] flex flex-col gap-[.56rem]")}>
      <div className="flex items-center gap-[.62rem]">
        <div className="flex flex-col items-center gap-[.31rem]">
          <div className={clsx("size-[0.4375rem] rounded-[0.0625rem] bg-gradient-to-r", data.vehicle.lock ? 'from-[#15B756] to-[#39E87F] border-[.0625rem] border-[#15B756]' : 'from-black-500/50 to-black-500/35')}></div>
          <img src={Lock} className="size-[1.0625rem]"/>
        </div>
        <div className="flex flex-col items-center gap-[.31rem]">
          <div className={clsx("size-[0.4375rem] rounded-[0.0625rem] bg-gradient-to-r", data.vehicle.seatbelt ? 'from-[#15B756] to-[#39E87F] border-[.0625rem] border-[#15B756]' : 'from-black-500/50 to-black-500/35')}></div>
          <img src={Seatbelt} className="size-[1.0625rem]"/>
        </div>
        <div className="flex flex-col items-center gap-[.31rem]">
          <div className={clsx("size-[0.4375rem] rounded-[0.0625rem] bg-gradient-to-r", data.vehicle.light ? 'from-[#15B756] to-[#39E87F] border-[.0625rem] border-[#15B756]' : 'from-black-500/50 to-black-500/35')}></div>
          <img src={Light} className="size-[1.0625rem]"/>
        </div>
      </div>
      <div className="h-9 flex items-center justify-between">
        <div className="h-full flex items-center gap-[.44rem]">
          <p className="text-white text-[3.125rem] font-bold">{data.vehicle.speed < 10 ? `00${data.vehicle.speed}` : data.vehicle.speed < 100 ? `0${data.vehicle.speed}` : data.vehicle.speed}</p>
          <div className="h-full flex items-center gap-[.38rem]">
            <p className="h-full bg-primary w-6 flex items-center justify-center text-white text-[0.9375rem] font-bold rounded-[0.0625rem]">{data.vehicle.march}</p>
            <img src={March} alt="March" />
          </div>
        </div>
        <div className="flex flex-col gap-1">
          <div className="flex items-center gap-[.31rem]">
            <img src={Engine} alt="Engine" className="w-4"/>
            <div className="w-[3.75rem] h-2 bg-black-500 rounded-[0.0625rem">
              <div className="h-full bg-gradient-to-r from-[#2C7EFF] to-[#2D6FD6] border-[.0625rem] border-[#2C7EFF]" style={{ width: `${data.vehicle.engine}%` }}></div>
            </div>
          </div>
          <div className="flex items-center gap-[.31rem]">
            <img src={Nitro} alt="Nitro" className="w-4"/>
            <div className="w-[3.75rem] h-2 bg-black-500 rounded-[0.0625rem">
              <div className="h-full bg-gradient-to-r from-[#FFD05D] to-[#CCA64A] border-[.0625rem] border-[#FFD05D]" style={{ width: `${data.vehicle.nitro}%` }}></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
