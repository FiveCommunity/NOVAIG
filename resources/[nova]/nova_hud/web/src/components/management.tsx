import Check from "/icons/check.svg";
import Rotate from "/icons/rotate.svg";
import Speedometer from "/icons/speedometer.svg";
import Food from "/icons/food.svg";

import Hud1 from "/images/hud1.png";
import Hud2 from "/images/hud2.png";
import Velocimeter1 from "/images/velocimeter1.png";
import Velocimeter2 from "/images/velocimeter2.png";
import { useHud } from "../hooks/useHud";
import { useEffect, useState } from "react";
import fetch from "../utils/fetch";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { isEnvBrowser } from "../utils/misc";

import Edit from "/icons/edit.svg";
import clsx from "clsx";


export default function Management() {
  const [openedManagement, setOpenedManagement] = useState(isEnvBrowser());

  const { updateHud, hud } = useHud();

  useNuiEvent<{ show: boolean }>("config", (data) => setOpenedManagement(Boolean(data.show)));

  function handleSave() {
    fetch("close", null, true);
    setOpenedManagement(false)
  }

  function handleReset() {
    updateHud({ velocimeter: 1, stats: 2 });
    fetch("close", null, true);
    setOpenedManagement(false)
  }

  useEffect(() => {
    if (!openedManagement) return

    const onKeyDown = ({ key }: KeyboardEvent) => {
      if (key === "Escape") {
        fetch("close", null, true);
      }
    };
    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, [openedManagement]);

  return openedManagement && (
    <div className="w-[33.75rem] absolute left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2 flex flex-col gap-[.56rem]">
      <div className="w-full h-[3.75rem] flex items-center justify-between px-[.62rem] rounded bg-gradient-to-r from-[#030303ED] to-[#030303E4]">
        <div className="flex items-center gap-[.44rem]">
          <div className="size-10 grid place-items-center bg-white/10 border-[.0625rem] border-white/15 rounded-[0.1875rem]">
            <img src={Edit} alt="Edit" />
          </div>
          <p className="text-white text-sm font-extrabold">EDITAR HUD</p>
        </div>
        <div className="flex items-center gap-[.38rem]">
          <button onClick={handleReset} className="w-[8.875rem] h-9 rounded-sm bg-white/10 border-[.0625rem] border-white/15 text-white/80 text-xs font-extrabold">CANCELAR</button>
          <button onClick={handleSave} className="w-[8.875rem] h-9 rounded-sm bg-primary border-[.0625rem] border-white/15 text-white text-xs font-extrabold">SALVAR</button>
        </div>
      </div>
      <div className="w-full px-5 pt-[.94rem] pb-5 rounded bg-gradient-to-r from-[#030303ED] to-[#030303E4] flex flex-col gap-[.62rem]">
        <div className="flex flex-col gap-[.62rem]">
          <div className="flex items-center gap-[.44rem]">
            <img src={Food} alt="food" />
            <p className="text-white text-xs font-extrabold">HUD</p>
          </div>
          <div className="flex items-center gap-[.62rem] w-full p-[.62rem] rounded-[.1875rem] border-[.0313rem] border-white/25 bg-gradient-to-r from-white/[.09] to-white/[.02]">
            <div className="w-[14.6875rem] flex flex-col gap-[.44rem]">
              <p className="text-white text-xs font-extrabold">HUD #1</p>
              <div className={clsx(hud.stats === 1 && '!border-primary from-[#D3132F1C] to-[#D3132F0D]', "w-full h-[8.125rem] border-[.0313rem] border-white/25 bg-gradient-to-r from-white/[.09] to-white/[.02] rounded-sm p-4 flex flex-col items-center justify-between")}>
                <img src={Hud1} className="h-1/2" />
                <button onClick={() => updateHud({ stats: 1, velocimeter: hud.velocimeter }) } className={clsx(hud.stats === 1 && '!bg-primary', "w-full h-[2.0625rem] rounded-sm border-[.05rem] border-white/15 bg-white/[.13] text-white text-[0.6875rem] font-extrabold")}>{hud.stats === 1 ? 'SELECIONADO' : 'SELECIONAR'}</button>
              </div>
            </div>
            <div className="w-[14.6875rem] flex flex-col gap-[.44rem]">
              <p className="text-white text-xs font-extrabold">HUD #2</p>
              <div className={clsx(hud.stats === 2 && '!border-primary from-[#D3132F1C] to-[#D3132F0D]', "w-full h-[8.125rem] pt-10 border-[.0313rem] border-white/25 bg-gradient-to-r from-white/[.09] to-white/[.02] rounded-sm p-4 flex flex-col items-center justify-between")}>
                <img src={Hud2} className="w-fit"  />
                <button onClick={() => updateHud({ stats: 2, velocimeter: hud.velocimeter }) } className={clsx(hud.stats === 2 && '!bg-primary', "w-full h-[2.0625rem] rounded-sm border-[.05rem] border-white/15 bg-white/[.13] text-white text-[0.6875rem] font-extrabold")}>{hud.stats === 2 ? 'SELECIONADO' : 'SELECIONAR'}</button>
              </div>
            </div>
          </div>
        </div>
        <div className="flex flex-col gap-[.62rem]">
          <div className="flex items-center gap-[.44rem]">
            <img src={Speedometer} alt="food" />
            <p className="text-white text-xs font-extrabold">VELOCIMETRO</p>
          </div>
          <div className="flex flex-col items-center gap-[.62rem] w-full p-[.62rem] rounded-[.1875rem] border-[.0313rem] border-white/25 bg-gradient-to-r from-white/[.09] to-white/[.02]">
            <div className={clsx(hud.velocimeter === 1 && '!border-primary from-[#D3132F1C] to-[#D3132F0D]', "w-full h-[10.625rem] rounded-sm border-[.0313rem] border-white/25 bg-gradient-to-r from-white/[.09] to-white/[.02] flex flex-col items-center justify-center gap-4")}>
              <p className="text-white text-xs font-extrabold">VELOCIMETRO #1</p>
              <img src={Velocimeter2} className="h-[3.84rem]"/>
              <button onClick={() => updateHud({ stats: hud.stats, velocimeter: 1 }) } className={clsx(hud.velocimeter === 1 && '!bg-primary !text-white' ,"w-[12.8125rem] h-[2.0625rem] rounded-sm border-[.05rem] border-white/15 bg-white/[.13] text-white/80 text-[0.6875rem] font-extrabold")}>{hud.velocimeter === 1 ? 'SELECIONADO' : 'SELECIONAR'}</button>
            </div>
            <div className={clsx(hud.velocimeter === 2 && '!border-primary from-[#D3132F1C] to-[#D3132F0D]', "w-full h-[10.625rem] rounded-sm border-[.0313rem] border-white/25 bg-gradient-to-r from-white/[.09] to-white/[.02] flex flex-col items-center justify-center gap-4")}>
              <p className="text-white text-xs font-extrabold">VELOCIMETRO #2</p>
              <img src={Velocimeter1} className="h-[3.7rem]"/>
              <button onClick={() => updateHud({ stats: hud.stats, velocimeter: 2 }) } className={clsx(hud.velocimeter === 2 && '!bg-primary !text-white' ,"w-[12.8125rem] h-[2.0625rem] rounded-sm border-[.05rem] border-white/15 bg-white/[.13] text-white/80 text-[0.6875rem] font-extrabold")}>{hud.velocimeter === 2 ? 'SELECIONADO' : 'SELECIONAR'}</button>
            </div>
          </div>
        </div>
      </div>
      {/* <div className="flex flex-col gap-[.94rem]">
        <div className="flex items-center gap-[.56rem]">
          <div className="flex-none w-10 h-[3rem] bg-hexagon bg-center bg-cover bg-no-repeat flex items-center justify-center">
            <img src={Speedometer} />
          </div>
          <h3 className="text-white text-2xl font-normal font-staatliches">
            VELOCIMETRO
          </h3>
        </div>
        <div className="flex items-center gap-[.94rem]">
          <div
            onClick={() =>
              updateHud({ stats: hud.stats, velocimeter: 1 })
            }
            className={`w-[17.5rem] h-[15.625rem] flex items-center justify-center rounded relative cursor-pointer bg-white/10 ${
              hud.velocimeter === 1
                ? "bg-white/25 before:content-[''] before:absolute before:w-[104%] before:h-[106%] before:bg-transparent before:border-[.0625rem] before:rounded-md before:border-white before:top-1/2 before:-translate-x-1/2 before:left-1/2 before:-translate-y-1/2"
                : "bg-white/10"
            }`}
          >
            <div className="absolute flex flex-col items-center top-5">
              <h3 className="text-white/90 text-sm font-bold">VELO V1</h3>
              <p className="text-white/65 text-[0.625rem] text-center font-normal">
                Para alternar o Velocimetro selecione <br /> o
                <b>modelo desejado.</b>
              </p>
            </div>
            <img
              src={Velocimeter1}
              className="w-[65%] mt-12"
              draggable={false}
            />
          </div>
          <div
            onClick={() =>
              updateHud({ stats: hud.stats, velocimeter: 2 })
            }
            className={`w-[17.5rem] h-[15.625rem] flex items-center justify-center rounded relative cursor-pointer ${
              hud.velocimeter === 2
                ? "bg-white/25 before:content-[''] before:absolute before:w-[104%] before:h-[106%] before:bg-transparent before:border-[.0625rem] before:rounded-md before:border-white before:top-1/2 before:-translate-x-1/2 before:left-1/2 before:-translate-y-1/2"
                : "bg-white/10"
            }`}
          >
            <div className="absolute flex flex-col items-center top-5">
              <h3 className="text-white/90 text-sm font-bold">VELO V2</h3>
              <p className="text-white/65 text-[0.625rem] text-center font-normal">
                Para alternar o Velocimetro selecione <br /> o
                <b>modelo desejado.</b>
              </p>
            </div>
            <img
              src={Velocimeter2}
              className="h-[50%] mt-12"
              draggable={false}
            />
          </div>
        </div>
      </div>
      <div className="flex flex-col gap-[.94rem]">
        <div className="flex items-center gap-[.56rem]">
          <div className="w-10 h-[3rem] bg-hexagon bg-center bg-cover bg-no-repeat flex items-center justify-center">
            <img src={HeartDuotone} />
          </div>
          <h3 className="text-white text-2xl font-normal font-staatliches">
            HUD
          </h3>
        </div>
        <div className="flex flex-col gap-3">
          <div
            onClick={() =>
              // setSelectedHud((state: any) => ({ ...state, stats: 1 }))
              updateHud({ stats: 1, velocimeter: hud.velocimeter })
            }
            className={`w-[36.25rem] h-[4.9375rem] rounded flex items-center justify-between relative px-4 ${
              hud.stats === 1
                ? "bg-white/25 before:content-[''] before:absolute before:w-[101%] before:h-[110%] before:bg-transparent before:border-[.0625rem] before:rounded-md before:border-white before:top-1/2 before:-translate-x-1/2 before:left-1/2 before:-translate-y-1/2"
                : "bg-white/10"
            }`}
          >
            <div>
              <div>
                <div></div>
                <p className="text-white text-sm font-bold">HUD V1</p>
              </div>
              <p className="text-white/55 text-[.625rem]">
                Para alternar o HUD selecione <br /> o <b> modelo desejado.</b>
              </p>
            </div>
            <img src={Hud1} className="w-[6.875rem]" />
          </div>
          <div
            onClick={() =>
              updateHud({ stats: 2, velocimeter: hud.velocimeter })
            }
            className={`w-[36.25rem] h-[4.9375rem] rounded flex items-center justify-between relative px-4 ${
              hud.stats === 2
                ? "bg-white/25 before:content-[''] before:absolute before:w-[101%] before:h-[110%] before:bg-transparent before:border-[.0625rem] before:rounded-md before:border-white before:top-1/2 before:-translate-x-1/2 before:left-1/2 before:-translate-y-1/2"
                : "bg-white/10"
            }`}
          >
            <div>
              <div>
                <div></div>
                <p className="text-white text-sm font-bold">HUD V2</p>
              </div>
              <p className="text-white/55 text-[.625rem]">
                Para alternar o HUD selecione <br /> o <b> modelo desejado.</b>
              </p>
            </div>
            <img src={Hud2} className="w-[18.375rem]" />
          </div>
        </div>
      </div>
      <div className="flex items-center justify-end gap-2">
        <button
          onClick={handleReset}
          className="w-[8.125rem] flex items-center justify-center gap-1 text-white text-sm font-bold h-[3.125rem] rounded border-[.0625rem] border-white/15 px-5 bg-white/10"
        >
          <img src={Rotate} />
          RESETAR
        </button>
        <button
          onClick={handleSave}
          className="flex items-center justify-center gap-1 w-[12.5rem] text-white text-sm font-bold h-[3.125rem] rounded border-[.0625rem] border-white/15 px-5 bg-white/10"
          style={{
            boxShadow: "inset 0 0 0 .0625rem #E51717",
            background:
              "linear-gradient(135deg, #E51717 -23.4%, rgba(229, 23, 23, 0.00) 129.13%), linear-gradient(0deg, rgba(0, 0, 0, 0.60) 0%, rgba(0, 0, 0, 0.60) 100%), linear-gradient(90deg, rgba(255, 255, 255, 0.20) 0%, rgba(255, 255, 255, 0.04) 100%)",
          }}
        >
          <img src={Check} />
          SALVAR
        </button>
      </div> */}
    </div>
  );
}
