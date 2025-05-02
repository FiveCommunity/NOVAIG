import Lock from "/icons/lock.svg";
import Gear from "/icons/gear.svg";
import Motor from "/icons/motor.svg";
import Engine from "/icons/engine.svg";
import Light from "/icons/light.svg";
import Nitro from "/icons/nitro.svg";
import March from "/icons/march.svg";
import Seatbelt from "/icons/belt.svg";
import { useData } from "../hooks/useData";
import clsx from "clsx";
import { useHud } from "../hooks/useHud";

export default function Velocimeter2() {
  const { hud } = useHud()
  const { data } = useData();

  return data.vehicle?.data && (
    <div className="w-[19.125rem] h-24 flex flex-col gap-[1.44rem] items-end relative">
      <div className="w-full flex items-center justify-end gap-[.31rem]">
        <img src={Nitro} alt="nitro" />
        <div className="w-20 h-2 rounded-[0.0625rem] bg-black-500">
          <div className="w-1/2 h-full bg-gradient-to-r from-[#2C7EFF] to-[#2D6FD6] rounded-[0.0625rem] border-[.0625rem] border-[#2C7EFF]"></div>
        </div>
      </div>
      <div className="w-full pl-24">
        <svg className="absolute left-12 bottom-0" width="261" height="77" viewBox="0 0 261 77" fill="none">
          <defs>
            <linearGradient id="paint0_linear_394_715" x1="-40.0227" y1="113" x2="264.667" y2="113" gradientUnits="userSpaceOnUse">
              <stop />
              <stop offset="1" stopOpacity="0.5" />
            </linearGradient>
          </defs>
          <path d="M0 86L31.5324 25.4486C38.0764 12.8822 51.068 5 65.2362 5H261" stroke="url(#paint0_linear_394_715)" strokeOpacity="0.65" strokeWidth="9" />
          <path d="M0 86L31.5324 25.4486C38.0764 12.8822 51.068 5 65.2362 5H261" stroke="#D3132F" pathLength="261" strokeWidth={9} strokeDasharray="261" strokeDashoffset={`${261 * (1 - (data.vehicle?.speed / 400))}`} />
        </svg>
        <div className="w-full flex items-start justify-between">
          <div className="flex flex-col gap-[.62rem]">
            <div className="flex items-center gap-[.44rem] h-[1.875rem]">
              <p className="text-white text-[2.625rem] text-center font-bold w-[5.0625rem]">{data.vehicle.speed < 10 ? `00${data.vehicle.speed}` : data.vehicle.speed < 100 ? `0${data.vehicle.speed}` : data.vehicle.speed}</p>
              <div className="flex items-center gap-[.38rem] h-full">
                <p className="text-white text-[0.9375rem] font-bold bg-primary h-full flex items-center justify-center w-6 rounded-sm">{data.vehicle.march}</p>
                <img src={March} alt="march" className="w-1/2"/>
              </div>
            </div>
            <div className="flex items-center gap-3">
              <div className="flex items-center gap-[.38rem]">
                <img src={Lock} alt="lock" />
                <div className={clsx("size-[0.5625rem] rounded-[0.0625rem] bg-gradient-to-r", data.vehicle.lock ? 'from-[#15B756] to-[#39E87F] border-[.0625rem] border-[#15B756]' : 'from-black-500/50 to-black-500/35')}></div>
              </div>
              <div className="flex items-center gap-[.38rem]">
                <img src={Seatbelt} alt="seatbelt" />
                <div className={clsx("size-[0.5625rem] rounded-[0.0625rem] bg-gradient-to-r", data.vehicle.seatbelt ? 'from-[#15B756] to-[#39E87F] border-[.0625rem] border-[#15B756]' : 'from-black-500/50 to-black-500/35')}></div>
              </div>
              <div className="flex items-center gap-[.38rem]">
                <img src={Light} alt="light" />
                <div className={clsx("size-[0.5625rem] rounded-[0.0625rem] bg-gradient-to-r", data.vehicle.light ? 'from-[#15B756] to-[#39E87F] border-[.0625rem] border-[#15B756]' : 'from-black-500/50 to-black-500/35')}></div>
              </div>
            </div>
          </div>
          <div className="relative pr-4">
            <div className="size-6 flex items-center justify-center bg-black-500 rounded-full">
              <img src={Engine} alt="motor" className="w-1/2"/>
            </div>
            <svg className="absolute right-0 top-2" width="22" height="33" viewBox="0 0 22 33" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M17.6647 2.97832C18.5889 5.67434 18.9549 8.53022 18.7405 11.3722C18.526 14.2141 17.7355 16.9827 16.4171 19.5095C15.0987 22.0363 13.28 24.2684 11.0716 26.07C8.86327 27.8716 6.31142 29.2051 3.57138 29.9892" stroke="url(#paint0_linear_394_712)" strokeOpacity="0.5" strokeWidth="5.77" strokeLinecap="round"/>
              <path d="M17.6647 2.97832C18.5889 5.67434 18.9549 8.53022 18.7405 11.3722C18.526 14.2141 17.7355 16.9827 16.4171 19.5095C15.0987 22.0363 13.28 24.2684 11.0716 26.07C8.86327 27.8716 6.31142 29.2051 3.57138 29.9892" stroke="#FFD05D" pathLength={100.01} strokeDasharray={100.01} strokeDashoffset={-data.vehicle.engine} strokeWidth="5.77" strokeLinecap="round"/>
              <defs>
              <linearGradient id="paint0_linear_394_712" x1="14.6867" y1="-7.10445" x2="-19.1044" y2="26.6867" gradientUnits="userSpaceOnUse">
              <stop/>
              <stop offset="1" stopOpacity="0.75"/>
              </linearGradient>
              </defs>
            </svg>
          </div>
        </div>
      </div>
    </div>
  ); 
}