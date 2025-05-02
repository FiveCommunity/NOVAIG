import clsx from "clsx";
import Loc from "../assets/loc.svg";
import { useData } from "../hooks/useData";
import { debugData } from "../utils/debugData";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { useState } from "react";

import User from "/icons/user.svg"
import Clock from "/icons/clock.svg"
import Radio from "/icons/radio.svg"
import Discord from "/icons/discord.svg"

interface TalkingProps {
  type?: 'append' | 'remove';
  name: string;
  uid: number;
}

debugData([
  {
    action: 'talking',
    data: {
      type: 'append',
      name: 'Naue',
      uid: 1
    }
  },
  {
    action: 'talking',
    data: {
      type: 'append',
      name: 'RIO KALASHINIKOV',
      uid: 1
    }
  },
])


export function Informations() {
  const { data } = useData();
  const [talking, setTalking] = useState<Omit<TalkingProps, 'type'>[]>([])


  useNuiEvent<TalkingProps>('talking', (data) => {
    if (data.type === 'append') {
      setTalking((prevState) => [data, ...prevState])
    } else {
      setTalking((prevState) => prevState.filter(({ uid }) => uid !== data.uid))
    }
    delete data.type
  })

  return (
    <div className="flex flex-col items-end gap-[.31rem]">
      <div className="flex items-center justify-center gap-[.31rem] h-[1.875rem] rounded-sm bg-black-500 px-2 w-full">
        <img src={Discord} alt="Discord" className="size-[1.125rem]"/>
        <p className="text-white text-xs font-bold">DISCORD.GG/NOVAIGUAÇU</p>
      </div>
      <div className="flex items-center gap-2">
        <div className="px-[.38rem] h-[1.875rem] flex items-center gap-[.31rem] rounded-sm bg-black-500">
          <img src={Clock} alt="Clock" className="size-[1.125rem]"/>
          <p className="text-white text-xs font-bold">{data.clock || '00:00'}</p>
        </div>
        {/* <div className="px-[.38rem] h-[1.875rem] flex items-center gap-[.31rem] rounded-sm bg-black-500">
          <img src={User} alt="User" className="size-[1.125rem]"/>
          <p className="text-white text-xs font-bold">{data.id || 0}</p>
        </div> */}
        {data.frequency && (
          <div className="px-[.38rem] h-[1.875rem] flex items-center gap-[.31rem] rounded-sm bg-black-500">
            <img src={Radio} alt="Radio" className="size-[1.125rem]"/>
            <p className="text-white text-xs font-bold">{data.frequency || 0} <b className="text-white/75 font-normal">MHz</b></p>
          </div>
        )}
        <div className={clsx("px-[.38rem] h-[1.875rem] flex items-center gap-[.31rem] rounded-sm", data.talking ? 'bg-primary' : 'bg-black-500')}>
          <svg className="size-5" viewBox="0 0 26 26" fill="none">
            <path d="M18.6875 11.375V13.8125C18.6875 15.3209 18.0883 16.7676 17.0217 17.8342C15.9551 18.9008 14.5084 19.5 13 19.5C11.4916 19.5 10.0449 18.9008 8.97833 17.8342C7.91172 16.7676 7.3125 15.3209 7.3125 13.8125V11.375H5.6875V13.8125C5.68835 15.6106 6.35168 17.3454 7.55074 18.6853C8.7498 20.0253 10.4005 20.8765 12.1875 21.0763V22.75H8.9375V24.375H17.0625V22.75H13.8125V21.0763C15.5995 20.8765 17.2502 20.0253 18.4493 18.6853C19.6483 17.3454 20.3116 15.6106 20.3125 13.8125V11.375H18.6875Z" fill="#DDDDDD"/>
            <path d="M13 17.875C14.0774 17.875 15.1108 17.447 15.8726 16.6851C16.6345 15.9233 17.0625 14.8899 17.0625 13.8125V5.6875C17.0625 4.61006 16.6345 3.57675 15.8726 2.81488C15.1108 2.05301 14.0774 1.625 13 1.625C11.9226 1.625 10.8892 2.05301 10.1274 2.81488C9.36551 3.57675 8.9375 4.61006 8.9375 5.6875V13.8125C8.9375 14.8899 9.36551 15.9233 10.1274 16.6851C10.8892 17.447 11.9226 17.875 13 17.875Z" fill="#DDDDDD" />
          </svg>
          <div className="flex gap-[.12rem]">
            <div className={clsx("size-2 bg-black-500/40 rounded-[0.0625rem]", data.volume >= 1 && 'bg-gradient-to-r from-[#FFFFFFD9] to-[#8C8C8CD9] border-[.05rem] border-white')}></div>
            <div className={clsx("size-2 bg-black-500/40 rounded-[0.0625rem]", data.volume >= 2 && 'bg-gradient-to-r from-[#FFFFFFD9] to-[#8C8C8CD9] border-[.05rem] border-white')}></div>
            <div className={clsx("size-2 bg-black-500/40 rounded-[0.0625rem]", data.volume >= 3 && 'bg-gradient-to-r from-[#FFFFFFD9] to-[#8C8C8CD9] border-[.05rem] border-white')}></div>
            <div className={clsx("size-2 bg-black-500/40 rounded-[0.0625rem]", data.volume >= 4 && 'bg-gradient-to-r from-[#FFFFFFD9] to-[#8C8C8CD9] border-[.05rem] border-white')}></div>
          </div>
        </div>
      </div>
      <div className="flex flex-col items-end absolute top-[16rem]">
        {talking.map(({ uid, name }, index) => (
          <div key={index} className="text-white font-medium text-xs flex items-center gap-1">
            [{uid}] - {name}
            <svg stroke="#70FF00" fill="#70FF00" strokeWidth="0" version="1.2" baseProfile="tiny" viewBox="0 0 24 24" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 16c-2.206 0-4-1.795-4-4v-6c0-2.205 1.794-4 4-4s4 1.795 4 4v6c0 2.205-1.794 4-4 4zm0-12c-1.103 0-2 .896-2 2v6c0 1.104.897 2 2 2s2-.896 2-2v-6c0-1.104-.897-2-2-2zM19 12v-2c0-.553-.447-1-1-1s-1 .447-1 1v2c0 2.757-2.243 5-5 5s-5-2.243-5-5v-2c0-.553-.447-1-1-1s-1 .447-1 1v2c0 3.52 2.613 6.432 6 6.92v1.08h-3c-.553 0-1 .447-1 1s.447 1 1 1h8c.553 0 1-.447 1-1s-.447-1-1-1h-3v-1.08c3.387-.488 6-3.4 6-6.92z" />
            </svg>
          </div>
        ))}
      </div>
    </div>
  );
}
