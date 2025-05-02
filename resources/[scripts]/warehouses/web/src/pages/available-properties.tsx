import { useCallback, useEffect, useMemo, useState } from "react"
import fetch from "../utils/fetch";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome/";
import { IconProp } from "@fortawesome/fontawesome-svg-core";
import clsx from "clsx";
import { ModalTryBuy } from "../components/modal-try-buy";

interface AvailablePropertiesProps {
  id: number;
  icon: string;
  name: string;
  price: number;
  image_url: string;
}

interface ModalProps {
  visible: boolean;
  price?: number;
  id?: number;
}

export function AvailablePropertiesPage() {
  const [availableProperties, setAvailableProperties] = useState<AvailablePropertiesProps[]>([])
  const [search, setSearch] = useState<string>('')
  const [modal, setModal] = useState<ModalProps>({ visible: false })

  useEffect(() => {
    fetch<AvailablePropertiesProps[]>('GET_AVAILABLE_PROPERTIES', null, [
      {
        id: 31,
        icon: 'fa-light fa-house',
        name: '<b>Apartamento</b> 31',
        price: 9999999,
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248001767766233118/image.png?ex=666213b8&is=6660c238&hm=846f678b4e31958516765e783530b622e749c50d311689537bbe12dafb7799cd&=&format=webp&quality=lossless&width=747&height=350'
      },
      {
        id: 31,
        icon: 'fa-light fa-house',
        name: '<b>Apartamento</b> 31',
        price: 9999999,
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248001767766233118/image.png?ex=666213b8&is=6660c238&hm=846f678b4e31958516765e783530b622e749c50d311689537bbe12dafb7799cd&=&format=webp&quality=lossless&width=747&height=350'
      },
      {
        id: 31,
        icon: 'fa-light fa-house',
        name: '<b>Apartamento</b> 31',
        price: 9999999,
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248001767766233118/image.png?ex=666213b8&is=6660c238&hm=846f678b4e31958516765e783530b622e749c50d311689537bbe12dafb7799cd&=&format=webp&quality=lossless&width=747&height=350'
      },
      {
        id: 31,
        icon: 'fa-light fa-house',
        name: '<b>Apartamento</b> 31',
        price: 9999999,
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248001767766233118/image.png?ex=666213b8&is=6660c238&hm=846f678b4e31958516765e783530b622e749c50d311689537bbe12dafb7799cd&=&format=webp&quality=lossless&width=747&height=350'
      },
      {
        id: 31,
        icon: 'fa-light fa-house',
        name: '<b>Apartamento</b> 31',
        price: 9999999,
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248001767766233118/image.png?ex=666213b8&is=6660c238&hm=846f678b4e31958516765e783530b622e749c50d311689537bbe12dafb7799cd&=&format=webp&quality=lossless&width=747&height=350'
      },
      {
        id: 31,
        icon: 'fa-light fa-house',
        name: '<b>Apartamento</b> 31',
        price: 9999999,
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248001767766233118/image.png?ex=666213b8&is=6660c238&hm=846f678b4e31958516765e783530b622e749c50d311689537bbe12dafb7799cd&=&format=webp&quality=lossless&width=747&height=350'
      },
      {
        id: 31,
        icon: 'fa-light fa-house',
        name: '<b>Apartamento</b> 31',
        price: 9999999,
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248001767766233118/image.png?ex=666213b8&is=6660c238&hm=846f678b4e31958516765e783530b622e749c50d311689537bbe12dafb7799cd&=&format=webp&quality=lossless&width=747&height=350'
      },
    ]).then(setAvailableProperties)
  }, [])

  const filteredAvailableProperties = useMemo(() => {
    return availableProperties
      .filter((propertie) => propertie.name.replaceAll(/<[^>]*>/gm, '').toLowerCase().includes(search.toLowerCase()))
  }, [search, availableProperties])

  return (
    <>
      <div className="flex flex-col gap-3 w-full h-full overflow-hidden">
        <div className="bg-neutral-600 w-full rounded-lg flex justify-between py-1.5 px-2.5">
          <span className="flex items-center gap-2 text-white font-medium leading-normal">
            <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path
                d="M15.4202 7.64156L9.79524 2.01656C9.58428 1.80574 9.29825 1.68732 9.00001 1.68732C8.70177 1.68732 8.41573 1.80574 8.20477 2.01656L2.57977 7.64156C2.4748 7.74576 2.39159 7.86978 2.33498 8.00642C2.27836 8.14306 2.24948 8.28959 2.25001 8.4375V15.1875C2.25001 15.3367 2.30927 15.4798 2.41476 15.5852C2.52025 15.6907 2.66332 15.75 2.81251 15.75H7.31251C7.46169 15.75 7.60477 15.6907 7.71025 15.5852C7.81574 15.4798 7.87501 15.3367 7.87501 15.1875V11.25H10.125V15.1875C10.125 15.3367 10.1843 15.4798 10.2898 15.5852C10.3952 15.6907 10.5383 15.75 10.6875 15.75H15.1875C15.3367 15.75 15.4798 15.6907 15.5853 15.5852C15.6907 15.4798 15.75 15.3367 15.75 15.1875V8.4375C15.7505 8.28959 15.7217 8.14306 15.665 8.00642C15.6084 7.86978 15.5252 7.74576 15.4202 7.64156ZM14.625 14.625H11.25V10.6875C11.25 10.5383 11.1907 10.3952 11.0853 10.2898C10.9798 10.1843 10.8367 10.125 10.6875 10.125H7.31251C7.16332 10.125 7.02025 10.1843 6.91476 10.2898C6.80927 10.3952 6.75001 10.5383 6.75001 10.6875V14.625H3.37501V8.4375L9.00001 2.8125L14.625 8.4375V14.625Z"
                fill="#808080"
              />
            </svg>
            Imóveis
          </span>

          <div className="relative w-fit h-fit">
            <svg className="absolute top-1/2 -translate-y-1/2 left-1.5" width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M12.5595 11.9405L9.82133 9.20282C10.615 8.25 11.0107 7.02789 10.9263 5.79072C10.8418 4.55355 10.2836 3.39656 9.36783 2.56046C8.45205 1.72435 7.24918 1.27349 6.00945 1.30166C4.76972 1.32984 3.58858 1.83488 2.71173 2.71173C1.83488 3.58858 1.32984 4.76972 1.30166 6.00945C1.27349 7.24918 1.72435 8.45205 2.56046 9.36783C3.39656 10.2836 4.55355 10.8418 5.79072 10.9263C7.02789 11.0107 8.25 10.615 9.20282 9.82133L11.9405 12.5595C11.9811 12.6002 12.0294 12.6324 12.0825 12.6544C12.1356 12.6764 12.1925 12.6877 12.25 12.6877C12.3075 12.6877 12.3644 12.6764 12.4175 12.6544C12.4706 12.6324 12.5189 12.6002 12.5595 12.5595C12.6002 12.5189 12.6324 12.4706 12.6544 12.4175C12.6764 12.3644 12.6877 12.3075 12.6877 12.25C12.6877 12.1925 12.6764 12.1356 12.6544 12.0825C12.6324 12.0294 12.6002 11.9811 12.5595 11.9405ZM2.1875 6.125C2.1875 5.34624 2.41843 4.58496 2.85109 3.93744C3.28375 3.28993 3.8987 2.78525 4.61819 2.48723C5.33767 2.18921 6.12937 2.11123 6.89317 2.26316C7.65697 2.41509 8.35857 2.7901 8.90924 3.34077C9.4599 3.89144 9.83492 4.59303 9.98685 5.35683C10.1388 6.12064 10.0608 6.91233 9.76278 7.63182C9.46476 8.3513 8.96008 8.96626 8.31256 9.39891C7.66504 9.83157 6.90377 10.0625 6.125 10.0625C5.08107 10.0613 4.08022 9.64613 3.34205 8.90796C2.60388 8.16978 2.18866 7.16894 2.1875 6.125Z" fill="#808080" />
            </svg>


            <input onChange={({ target }) => setSearch(target.value)} type="text" placeholder="Pesquisar" className="pl-6 py-1 bg-neutral-900 placeholder:text-white/45 rounded-[5px] focus:outline-none text-white text-sm leading-none" />
          </div>
        </div>
        <div className="bg-neutral-600 w-full h-full rounded-lg p-4 overflow-hidden">
          <div className="h-full flex flex-wrap content-start gap-3 overflow-y-auto">
            {filteredAvailableProperties.map(properties => (
              <div className="rounded-[5px] bg-white/[0.01] p-2.5 flex flex-col gap-2.5 max-w-[19.9375rem] w-full max-h-[12.5rem]">
                <img src={properties.image_url} />
                <div className="w-full flex justify-between items-center">
                  <span className="h-[30px] px-3 py-1.5 flex gap-2 items-center bg-white/[0.03] rounded-[5px]">
                    <i className={clsx(properties.icon, 'text-white/45')}></i>
                    <p className="text-white/45 font-medium text-sm [&>b]:!text-white/75" dangerouslySetInnerHTML={{ __html: properties.name }} />
                  </span>
                  <span onClick={() => setModal({ visible: true, price: properties.price, id: properties.id })} className="h-[30px] px-3 py-1.5 flex gap-2 items-center group bg-white/[0.03] rounded-[5px]">
                    <i className="fa-light fa-cart-shopping text-white/45 cursor-pointer transition-all group-hover:!text-white/100"></i>
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>

      </div>
      {modal.visible && <ModalTryBuy price={modal.price!} id={modal.id!} onClose={() => setModal({ visible: false })} />}
    </>
  )
}