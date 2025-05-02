import { VisibilityProvider } from "./providers/visibility";

import { PlayerStats } from "./components/player-stats";
import { Velocimeter } from "./components/velocimeter";

import Logo from "/images/logo.png";
import Cupom from "/images/cupom.png";
import Safezone from "/images/safezone.png";
import Bullets from "/icons/bullets.svg";

import { useNuiEvent } from "./hooks/useNuiEvent";
import { useEffect, useState } from "react";
import { Informations } from "./components/informations";
import { Assault } from "./components/assault";
import { NotifyList } from "./components/notify-list";
import { Progress } from "./components/progress";
import OthersInformations from "./components/others-informations";
import { IData, useData } from "./hooks/useData";
import { debugData } from "./utils/debugData";
import { PlayerStats2 } from "./components/player-stats2";
import Velocimeter2 from "./components/velocimeter2";
import Management from "./components/management";
import { useHud } from "./hooks/useHud";
import clsx from "clsx";

import Makapoints from "/images/makapoints.png";
import { isEnvBrowser } from "./utils/misc";
import Weapon from "./components/weapon";
import { Clock } from "./components/clock";
import Street from "./components/street";

/* debugData([{ action: "config", data: { show: true } }]); */

// setInterval(() => {
//   debugData([
//     {
//       action: "update",
//       data: {
//         health: Math.round(Math.random() * 100),
//         armour: Math.round(Math.random() * 100),
//         street: "asdsad",
//         talking: true,
//         volume: 3,
//         frequency: 100,
//         vehicle: {
//           show: true,
//           rpm: Math.round(Math.random() * 100),
//           speed: Math.round(Math.random() * 400),
//           engine: Math.round(Math.random() * 100),
//           nitro: Math.round(Math.random() * 100),
//           fuel: Math.round(Math.random() * 100),
//           march: 1,
//           light: true,
//           seatbeat: false,
//           lock: false,
//         },
//         weapon: {
//           show: true,
//           image: "test",
//           current: 10,
//           max: 20,
//         },
//       },
//     },
//   ]);
// }, 1000);
debugData([
  {
    action: "update",
    data: {
      id: 232,
      health: Math.round(Math.random() * 100),
      armour: Math.round(Math.random() * 100),
      street: "asdsad",
      talking: true,
      volume: 3,
      frequency: 100,
      vehicle: {
        show: true,
        rpm: 50,
        speed: Math.round(Math.random() * 400),
        engine: Math.round(Math.random() * 100),
        nitro: Math.round(Math.random() * 100),
        fuel: Math.round(Math.random() * 100),
        march: 1,
        light: true,
        seatbelt: true,
        lock: false,
      },
      weapon: {
        show: true,
        image: "test",
        current: 10,
        max: 20,
      },
    },
  },
]);

export function App() {
  const { data, updateData } = useData();
  const { hud } = useHud();
  const [safe, setSafe] = useState(true);
  const [assault, setAssault] = useState(true);
  const [showCupom, setShowCupom] = useState(true);
  const [makapoints, setMakapoints] = useState({ visible: isEnvBrowser(), points: 0 });

  useNuiEvent<IData>("update", (data) => {
    updateData(data);
    if (data.safezone !== undefined) setSafe(data.safezone);
    if (data.assaultTime !== undefined) setAssault(data.assaultTime);
  });

  useNuiEvent("showCupom", setShowCupom);
  useNuiEvent("makapoints", setMakapoints);

  return (
    <VisibilityProvider>
      <div className="flex flex-col items-center gap-4 absolute top-6 -translate-x-1/2 left-1/2">
        <img src={Logo} alt="logo" className="logo" />
        {safe && <img src={Safezone} className="h-8" />}
        {makapoints?.visible && (
          <div
            className="flex items-center gap-2 border-[1px] border-[#882BFF] rounded-lg px-2"
            style={{ background: "linear-gradient(153deg, #882BFF 0%, rgba(0, 0, 0, 0.00) 100%), rgba(0, 0, 0, 0.75)" }}
          >
            <img src={Makapoints} alt="makapoints" className="w-6" />
            <p className="text-white text-sm font-normal">
              <b>{makapoints.points}</b> MAKAPOINTS ADICIONADOS
            </p>
          </div>
        )}
      </div>

      {showCupom && (
        <div className="absolute left-4 top-1/2 -translate-y-1/2 flex flex-col items-center">
          <img src={Cupom} className="cupom" />
          <p className="text-white text-xs font-normal text-shadow-sm text-shadow-black -mt-4">
            Digite <b>/ocultar</b> para ocultar o cupom
          </p>
        </div>
      )}

      <Progress />
      <OthersInformations />
      <Management />

      <div className="h-full flex flex-col gap-4 justify-between items-end overflow-hidden">
        <div className="h-full flex flex-col items-end gap-4 overflow-hidden">
          <Informations />
          {assault && <Assault />}
          {data.weapon?.show && <Weapon {...data.weapon} />}
          <NotifyList />
        </div>
        <div className={clsx("flex flex-col items-end gap-2")}>
          {hud.velocimeter === 1 ? <Velocimeter /> : <Velocimeter2 />}
          {hud.stats === 1 ? <PlayerStats /> : <PlayerStats2 />}
        </div>
      </div>

      <Clock />
      {/* <Street /> */}
    </VisibilityProvider>
  );
}
