import { useEffect, useState } from "react";
import clsx from "clsx";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";

import Bell from "/icons/bell.svg";
import Megaphone from "/icons/megaphone.svg";
import HProgress from "/images/h-progress.png";

interface NotifyProps {
  id: string;
  type: any;
  title: string;
  message: string;
  time: number;
  createdAt: number;
}

interface AnnouceProps {
  type: string;
  icon?: string;
  title: string;
  message: string;
  author?: string;
  time: number;
  createdAt: number;
}

debugData([
  {
    action: "Notify",
    data: {
      title: "NOVO VIP DIVULGADO",
      type: "refused",
      message: "asdsa",
      time: 500,
    },
  },
  // {
  //   action: "Notify",
  //   data: {
  //     title: "NOVO VIP DIVULGADO",
  //     type: "success",
  //     message:
  //       "Olá Moradores, <br>Nosso novo VIP Irá ser lançado hoje ás 19h em nossa loja. <br><br>Os 10 <b>primeiros</b> a comprarem irão receber um caminhao Mule 2000kg.<br><br>CUPOM: WIPE50",
  //     time: 40000,
  //   },
  // },
  // {
  //   action: "Notify",
  //   data: {
  //     title: "NOVO VIP DIVULGADO",
  //     type: "important",
  //     message:
  //       "Olá Moradores, <br>Nosso novo VIP Irá ser lançado hoje ás 19h em nossa loja. <br><br>Os 10 <b>primeiros</b> a comprarem irão receber um caminhao Mule 2000kg.<br><br>CUPOM: WIPE50",
  //     time: 3000,
  //   },
  // },

  // {
  //   action: "Notify",
  //   data: {
  //     title: "NOVO VIP DIVULGADO",
  //     type: "refused",
  //     message:
  //       "Olá Moradores, <br>Nosso novo VIP Irá ser lançado hoje ás 19h em nossa loja. <br><br>Os 10 <b>primeiros</b> a comprarem irão receber um caminhao Mule 2000kg.<br><br>CUPOM: WIPE50",
  //     time: 3000,
  //   },
  // },
  // {
  //   action: "Notify",
  //   data: {
  //     title: "NOVO VIP DIVULGADO",
  //     type: "aaa",
  //     message:
  //       "Olá Moradores, <br>Nosso novo VIP Irá ser lançado hoje ás 19h em nossa loja. <br><br>Os 10 <b>primeiros</b> a comprarem irão receber um caminhao Mule 2000kg.<br><br>CUPOM: WIPE50",
  //     time: 3000,
  //   },
  // },
  // {
  //   action: "Notify",
  //   data: {
  //     title: "NOVO VIP DIVULGADO",
  //     type: "admin",
  //     message:
  //       "<br><b>🔫 Armas</b>:<br> 🔫 Croacia <b>0</b><br>🔫 COMANDO VERMELHO <b>0</b> <br>🔫 Inglaterra <b>0</b> <br>🔫 PCC <b>0</b> <br>🔫 MAFIA <b>0</b> <br>🔫 Grota <b>0</b> <br><br><b>📦 Municao</b>:<br> 📦 França <b>0</b><br>📦 TCP <b>0</b> <br>📦 Yakuza <b>0</b> <br>📦 Magnatas <b>0</b> <br>📦 Turquia <b>0</b> <br>📦 CPX <b>0</b> <br><br><b>⛓ Desmanche</b>:<br> ⛓ Grecia <b>0</b><br>⛓ Bennys <b>0</b> <br>⛓ MotoClube <b>0</b> <br>⛓ Lacoste <b>0</b> <br>⛓ Ballas <b>0</b> <br><br><b>💵 Lavagem</b>:<br> 💵 Bahamas <b>0</b><br>💵 Lux <b>0</b> <br>💵 Mainstreet <b>0</b> <br>💵 Galaxy <b>0</b> <br>💵 Cassino <b>0</b> <br><br><b>💊 Drogas</b>:<br> 💊 Jamaica <b>0</b><br>💊 Suecia <b>0</b> <br>💊 Mexico <b>0</b> <br>💊 Anonymous <b>0</b> <br>💊 Elements <b>0</b> <br>💊 Vagos <b>0</b> <br>💊 Mercenarios <b>0</b> <br>💊 Colombia <b>0</b> <br>💊 Vidigal <b>0</b> <br>💊 Belgica <b>0</b> <br> <br> <b>🌇 Ilegal: </b>0<br><b>🏘️ Total de jogadores Online: </b>102.",
  //     time: 5000,
  //   },
  // },
  {
    action: "Announcement",
    data: {
      title: "Aviso Mecanico",
      type: "juridico",
      icon: "./icons/juridico.png",
      message:
        "POLICIA INFORMA: Recrutamento Policia Baixada RJ aberto, interessados compararecer ao Departamento de Policia 2 (DP2). Verifique o fardamento e manual de conduta no e-mail na aba - RECRUTAMENTO LEGAL.",
      time: 5000,
    },
  },
  {
    action: "Announcement",
    data: {
      title: "RECRUTAMENTO",
      type: "recruitment",
      icon: "./icons/juridico.png",
      message: `📢 Estados Unidos (FAC DE LAVAGEM) GANHE 2 VEICULOS VIPS + SALARIO DE 5K A CADA 30 MINUTOS digite /rec para receber a localização.`,
      time: 5000,
    },
  },
  {
    action: "Announcement",
    data: {
      title: "RECRUTAMENTO",
      type: "recruitment",
      icon: "./icons/kids.png",
      message: `
        📢 Estados Unidos (FAC DE LAVAGEM) GANHE 2
        VEICULOS VIPS + SALARIO DE 5K A CADA 30
        MINUTOS digite /rec para receber a localização.  
      `,
      time: 5000,
    },
  },
  // {
  //   action: "Announcement",
  //   data: {
  //     title: "Aviso hospital",
  //     type: "hospital",
  //     icon: "./icons/hospital.png",
  //     message:
  //       "POLICIA INFORMA: Recrutamento Policia Baixada RJ aberto, interessados compararecer ao Departamento de Policia 2 (DP2). Verifique o fardamento e manual de conduta no e-mail na aba - RECRUTAMENTO LEGAL.",
  //     time: 5000,
  //   },
  // },
  // {
  //   action: "Announcement",
  //   data: {
  //     title: "Aviso BOMBEIROS",
  //     type: "fireman",
  //     icon: "./icons/fireman.png",
  //     message:
  //       "POLICIA INFORMA: Recrutamento Policia Baixada RJ aberto, interessados compararecer ao Departamento de Policia 2 (DP2). Verifique o fardamento e manual de conduta no e-mail na aba - RECRUTAMENTO LEGAL.",
  //     time: 5000,
  //   },
  // },
  // {
  //   action: "Announcement",
  //   data: {
  //     title: "Aviso vip",
  //     type: "vip",
  //     icon: "./icons/vip.png",
  //     message:
  //       "POLICIA INFORMA: Recrutamento Policia Baixada RJ aberto, interessados compararecer ao Departamento de Policia 2 (DP2). Verifique o fardamento e manual de conduta no e-mail na aba - RECRUTAMENTO LEGAL.",
  //     time: 5000,
  //   },
  // },
]);

export function NotifyList() {
  const [notifys, setNotifys] = useState<NotifyProps[]>([]);
  const [announces, setAnnounces] = useState<AnnouceProps[]>([]);
  const [hideRecruitment, setHideRecruitment] = useState(false);

  useEffect(() => {
    const interval = setInterval(() => {
      setNotifys((prevState) => {
        const now = Date.now();
        return prevState.filter(({ createdAt, time }) => createdAt + time > now);
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [notifys]);

  useEffect(() => {
    if (announces.length === 0) return;

    if (hideRecruitment && announces[0].type === "recruitment") {
      setAnnounces((prevState) => {
        const newState = [...prevState];
        newState.shift();
        return newState;
      });
      return;
    }

    if (!announces[0].createdAt) announces[0].createdAt = Date.now();

    const timeout = setTimeout(() => {
      setAnnounces((prevState) => {
        const newState = [...prevState];

        if (newState[1] && !newState[1].createdAt) newState[1].createdAt = Date.now();

        newState.shift();
        return newState;
      });
    }, announces[0].createdAt + announces[0].time - Date.now());

    return () => clearTimeout(timeout);
  }, [announces, hideRecruitment]);

  useNuiEvent<NotifyProps>("Notify", (data) => {
    data.createdAt = Date.now();
    setNotifys((prevState) => [{ ...data, id: `${data.createdAt}-${prevState.length}` }, ...prevState]);
  });

  useNuiEvent<AnnouceProps>("Announcement", (data) => {
    setAnnounces((prevState) => [...prevState, data]);
  });

  useNuiEvent<boolean>("HideRecruitment", (data) => {
    setHideRecruitment(data);
  });

  return (
    <div className="flex flex-col items-end gap-6 mt-2 h-full relative w-[25.625rem]">
      <div className="h-full flex flex-col items-end gap-6 z-20 absolute">
        {notifys.map((notify) => (
          <div
            key={notify.id}
            className={clsx("notify w-[21.25rem] px-5 pt-[.94rem] flex flex-col gap-[.94rem] rounded-sm", notify.type)}
          >
            <div className="flex items-start gap-2">
              <div className="size-9 flex-none bg-[var(--color-primary)] rounded-full flex items-center justify-center">
                <img src={Bell} alt="Bell" className="size-1/2" />
              </div>
              <div>
                <h4 className="uppercase text-white text-sm font-extrabold">{notify.title}</h4>
                <p
                  className={clsx(
                    "text-white text-[0.8125rem] font-normal",
                    notify.message.length > 120 && "leading-[0.8rem]"
                  )}
                  dangerouslySetInnerHTML={{ __html: notify.message }}
                ></p>
              </div>
            </div>
            <div className="w-full h-1 bg-white/10">
              <div
                className="h-full bg-[var(--color-primary)] transition-all ease-linear"
                style={{
                  animation: "degress",
                  animationTimingFunction: "linear",
                  animationFillMode: "both",
                  animationDuration: notify.time + "ms",
                }}
              ></div>
            </div>
          </div>
        ))}
      </div>
      {announces.length > 0 && (
        <div
          key={announces[0].createdAt}
          className={`${announces[0].type} w-full flex-none px-5 pt-[.94rem] flex flex-col gap-5 animate-fade-left rounded-md max-w-[25.625rem] announce absolute bottom-0`}
        >
          <div className="flex items-center gap-5 h-full">
            {announces[0].type === "recruitment" ? (
              <div className="w-[3.625rem] h-[4.25rem] bg-recruitment bg-cover bg-no-repeat flex-none flex items-center justify-center relative">
                <img src={Megaphone} className="size-6 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2"/>
                <div className="size-[3.5rem] relative flex">
                  <img src={HProgress} alt="" className="w-full h-full opacity-40 absolute left-0 top-0"/>
                  <div className="size-full bg-h-progress bg-cover bg-no-repeat rotate-180 self-end" style={{ animation: `h-progress ${announces[0].time}ms linear`}}></div>
                </div>
              </div>
            ) : (
              <img src={announces[0].icon} className="h-[4.0625rem]" />
            )}
            <hr
              className="w-[0.0625rem] h-[6.1875rem] flex-none border-none"
              style={{
                background:
                  "linear-gradient(0deg, rgba(255, 255, 255, 0.00) 0%, rgba(255, 255, 255, 0.12) 50%, rgba(255, 255, 255, 0.00) 100%)",
              }}
            />
            <div className="flex flex-col gap-[.44rem]">
              <h3 className="text-white text-[0.9375rem] font-extrabold"> {announces[0].title.toUpperCase()} </h3>
              <p
                className="text-white/80 text-[0.8125rem] font-normal"
                dangerouslySetInnerHTML={{ __html: announces[0].message }}
              ></p>
              {
                announces[0].type === "recruitment" && (
                  <>
                    <div className="flex items-center gap-[.38rem]">
                      <div className="size-[1.875rem] bg-[#D3132F] flex items-center justify-center text-white text-base font-bold rounded">
                        Y
                      </div>
                      <p className="border-[.0625rem] border-white/20 h-[1.875rem] rounded text-white text-[0.6875rem] font-bold bg-white/15 flex items-center justify-center px-[.69rem] uppercase">
                        Marcar Localização
                      </p>
                    </div>
                    <p className="text-white text-[0.8125rem] font-bold">/hiderec para ocultar</p>
                  </>
                )
              }
              {announces[0].author && (
                <p className="text-white/85 text-[0.8125rem] font-medium mt-[.94rem]">
                  <b className="text-white/25">Autor:</b> {announces[0].author}
                </p>
              )}
            </div>
          </div>
          <div className="w-full h-1 bg-white/10" style={{ borderRadius: "0.0625rem 0.0625rem 0rem 0rem" }}>
            <div
              className="h-full bg-[var(--color-primary)]"
              style={{
                animation: "degress",
                animationTimingFunction: "linear",
                animationFillMode: "both",
                animationDuration: announces[0].time + "ms",
              }}
            ></div>
          </div>
        </div>
      )}
    </div>
  );
}
