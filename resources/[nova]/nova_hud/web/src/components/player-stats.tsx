import clsx from "clsx";
import { useData } from "../hooks/useData";
import { useHud } from "../hooks/useHud";

import Heart from "/icons/heart.svg"
import Shield from "/icons/shield.svg"

export function PlayerStats() {
  const { hud } = useHud();
  const { data } = useData();

  return (
    <div className={clsx("flex items-center gap-[.38rem]", hud.velocimeter === 2 && data.vehicle?.data && 'absolute bottom-5 right-[14.5rem] flex-col gap-0', (hud.velocimeter === 1 && data.vehicle?.data) && 'absolute bottom-16')}>
      <div className="size-10 overflow-hidden bg-black-500/70 rounded-full border-[.0625rem] border-primary relative">
        <div className="size-full overflow-hidden bg-primary/40 rounded-full flex items-end ">
          <img src={Heart} alt="Heart" className="w-1/2 absolute left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2" />
          <div className="w-full bg-primary" style={{ height: `${data.health}%`}}></div>
        </div>
      </div>
      <div className={clsx(hud.velocimeter === 2 &&  'mr-12', "size-10 overflow-hidden bg-black-500/70 rounded-full border-[.0625rem] border-[#8D42F5] relative")}>
        <div className="size-full overflow-hidden bg-[#8D42F566] rounded-full flex items-end relative">
          <img src={Shield} alt="Shield" className="w-1/2 absolute left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2" />
          <div className="w-full bg-[#8D42F5]" style={{ height: `${data.armour}%`}}></div>
        </div>
      </div>
    </div>
  );
}
