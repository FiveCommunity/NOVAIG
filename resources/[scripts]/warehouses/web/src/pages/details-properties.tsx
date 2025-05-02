import { useEffect, useState } from "react"
import { useNavigate, useParams } from "react-router-dom"
import fetch from "../utils/fetch"
import clsx from "clsx";
import { ModalMembers } from "../components/modal-members";

interface MemberProps {
  uid: number;
  name: string;
}

interface PropertiesProps {
  id: number | string;
  name: string;
  icon: string;
  image_url: string;
  rent_expires_in: string;
  rent_price?: number;
  chest_weight: number;
  increased_quantity_weight: number;
  buy_weight_price: number;
  buy_garage_price: number;
  max_members: 10,
  members: MemberProps[];
}

export function DetailsPropertiesPage() {
  const [properties, setProperties] = useState<PropertiesProps | null>(null)
  const [modalVisible, setModalVisible] = useState<boolean>(false)
  const { id } = useParams()
  const navigate = useNavigate()

  useEffect(() => {
    if (!id) return navigate('/')
    

    fetch<PropertiesProps>('GET_DETAILS_PROPERTY', id, {
      id: 2,
      name: 'Propriedade dos pintudos',
      icon: 'fa-light fa-house',
      image_url: 'https://media.discordapp.net/attachments/852964597103329322/1248035080279035996/image.png?ex=666232be&is=6660e13e&hm=35bfdd911d13a7d1b89874a91814b4ebc2217448d3fd5b16a6b2198861015348&=&format=webp&quality=lossless&width=1260&height=242',
      rent_expires_in: '10 dias',
      chest_weight: 1000,
      increased_quantity_weight: 100,
      buy_weight_price: 1000,
      buy_garage_price: 1000,
      rent_price: 10000000000000,
      max_members: 10,
      members: [
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
        {
          name: 'Haniel silva',
          uid: 2,
        },
      ]
    }).then(setProperties)
  }, [])

  
  return properties && (
    <>
      <div className="flex flex-col gap-3">
        <div className="flex flex-col gap-5 rounded-lg py-2.5 px-4 bg-neutral-600">
          <div className="flex flex-col gap-6">
            <div className="text-white font-medium flex items-center gap-2">
              <i className={clsx(properties.icon, 'text-[#808080]')}></i>
              {properties.name}
              <span className="flex gap-0.5 px-2 py-1.5 bg-white/5 rounded text-xs text-white/45">Aluguel vence em {" "}<span className="text-white/75"> {properties.rent_expires_in}</span></span>
            </div>
            <img className="rounded-md" src={properties.image_url} alt="" />
          </div>
        </div>
        <div className="w-full flex flex-col gap-3 rounded-lg py-2.5 px-4 bg-neutral-600">
          <div className="w-full flex flex-col gap-2.5">
            <div className="w-full rounded-[.3125rem] bg-white/[0.01] p-2 flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <circle cx="16" cy="16" r="16" fill="white" fill-opacity="0.04" />
                  <path d="M19.5 10.5H12.5C11.572 10.501 10.6824 10.8701 10.0262 11.5262C9.37006 12.1824 9.00099 13.072 9 14V20C9 20.2652 9.10536 20.5196 9.29289 20.7071C9.48043 20.8946 9.73478 21 10 21H22C22.2652 21 22.5196 20.8946 22.7071 20.7071C22.8946 20.5196 23 20.2652 23 20V14C22.999 13.072 22.6299 12.1824 21.9738 11.5262C21.3176 10.8701 20.428 10.501 19.5 10.5ZM22 14V14.5H20V11.55C20.5643 11.666 21.0714 11.9731 21.4357 12.4194C21.8 12.8656 21.9993 13.4239 22 14ZM16.5 16.5H15.5V14.5H16.5V16.5ZM15 17.5H17C17.1326 17.5 17.2598 17.4473 17.3536 17.3536C17.4473 17.2598 17.5 17.1326 17.5 17V15.5H19V20H13V15.5H14.5V17C14.5 17.1326 14.5527 17.2598 14.6464 17.3536C14.7402 17.4473 14.8674 17.5 15 17.5ZM17.5 14.5V14C17.5 13.8674 17.4473 13.7402 17.3536 13.6464C17.2598 13.5527 17.1326 13.5 17 13.5H15C14.8674 13.5 14.7402 13.5527 14.6464 13.6464C14.5527 13.7402 14.5 13.8674 14.5 14V14.5H13V11.5H19V14.5H17.5ZM12 11.55V14.5H10V14C10.0007 13.4239 10.2 12.8656 10.5643 12.4194C10.9286 11.9731 11.4357 11.666 12 11.55ZM10 15.5H12V20H10V15.5ZM22 20H20V15.5H22V20Z" fill="white" />
                </svg>
                <span className="text-white font-medium text-sm flex items-center gap-5">
                  Aumentar {properties.increased_quantity_weight} KG no Baú      <span className="text-white/35">(Atual: {properties.chest_weight}KG)</span>
                </span>
              </div>
              <button onClick={() => fetch('INCREASE_WEIGHT_PROPERTY', id, true)} className="h-7 px-3 flex items-center rounded-[.3125rem] font-medium text-white bg-gradient-to-r from-primary-500 to-primary-600">Adquirir R$ {new Intl.NumberFormat('en-DE').format(properties.buy_weight_price)}</button>
            </div>
            <div className="w-full rounded-[.3125rem] bg-white/[0.01] p-2 flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <circle cx="16" cy="16" r="16" fill="white" fill-opacity="0.04" />
                  <path d="M23 19.9998H22.5V14.1667C22.5 14.0021 22.4594 13.8401 22.3818 13.695C22.3041 13.5499 22.1919 13.4262 22.055 13.3348L16.555 9.66794C16.3907 9.55844 16.1977 9.5 16.0003 9.5C15.8029 9.5 15.6099 9.55844 15.4456 9.66794L9.94562 13.3348C9.80861 13.4261 9.69625 13.5498 9.61851 13.6949C9.54077 13.84 9.50006 14.0021 9.5 14.1667V19.9998H9C8.86739 19.9998 8.74021 20.0525 8.64645 20.1463C8.55268 20.24 8.5 20.3672 8.5 20.4998C8.5 20.6324 8.55268 20.7596 8.64645 20.8534C8.74021 20.9471 8.86739 20.9998 9 20.9998H23C23.1326 20.9998 23.2598 20.9471 23.3536 20.8534C23.4473 20.7596 23.5 20.6324 23.5 20.4998C23.5 20.3672 23.4473 20.24 23.3536 20.1463C23.2598 20.0525 23.1326 19.9998 23 19.9998ZM10.5 14.1667L16 10.4998L21.5 14.1661V19.9998H20V16.4998C20 16.3672 19.9473 16.24 19.8536 16.1463C19.7598 16.0525 19.6326 15.9998 19.5 15.9998H12.5C12.3674 15.9998 12.2402 16.0525 12.1464 16.1463C12.0527 16.24 12 16.3672 12 16.4998V19.9998H10.5V14.1667ZM19 16.9998V17.9998H16.5V16.9998H19ZM15.5 17.9998H13V16.9998H15.5V17.9998ZM13 18.9998H15.5V19.9998H13V18.9998ZM16.5 18.9998H19V19.9998H16.5V18.9998Z" fill="white" />
                </svg>

                <span className="text-white font-medium text-sm flex items-center gap-5">
                  Comprar garagem
                </span>
              </div>
              <button onClick={() => fetch('BUY_GARAGE', id)} className="h-7 px-3 flex items-center rounded-[.3125rem] font-medium text-white bg-gradient-to-r from-primary-500 to-primary-600">Adquirir R$ {new Intl.NumberFormat('en-DE').format(properties.buy_garage_price)}</button>
            </div>
            <div className="w-full rounded-[.3125rem] bg-white/[0.01] p-2 flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <circle cx="16" cy="16" r="16" fill="white" fill-opacity="0.04" />
                  <path d="M23.6484 11.7032L20.2974 8.35156C20.186 8.2401 20.0537 8.15169 19.908 8.09137C19.7624 8.03105 19.6064 8 19.4488 8C19.2911 8 19.1351 8.03105 18.9895 8.09137C18.8439 8.15169 18.7116 8.2401 18.6001 8.35156L9.35176 17.6002C9.23984 17.7112 9.15111 17.8434 9.09073 17.989C9.03034 18.1346 8.9995 18.2908 9.00001 18.4484V21.8C9.00001 22.1183 9.12644 22.4235 9.35148 22.6485C9.57653 22.8736 9.88176 23 10.2 23H13.5518C13.7095 23.0005 13.8656 22.9697 14.0113 22.9093C14.1569 22.8489 14.289 22.7602 14.4001 22.6483L23.6484 13.4004C23.7599 13.2889 23.8483 13.1566 23.9086 13.011C23.969 12.8654 24 12.7094 24 12.5518C24 12.3942 23.969 12.2381 23.9086 12.0925C23.8483 11.9469 23.7599 11.8146 23.6484 11.7032ZM13.5518 21.8H10.2V18.4484L16.8001 11.8487L20.1519 15.2003L13.5518 21.8ZM21.0001 14.3513L17.6484 11.0005L19.4484 9.20052L22.8002 12.5514L21.0001 14.3513Z" fill="white" />
                </svg>


                <span className="text-white font-medium text-sm flex items-center gap-5">Renomear</span>
              </div>
              <button onClick={() => fetch('RENAME_PROPERTY', id, true)} className="h-7 px-3 flex items-center rounded-[.3125rem] font-medium text-white bg-white/[0.04]">
                Renomear
              </button>
            </div>
            <div className="w-full rounded-[.3125rem] bg-white/[0.01] p-2 flex items-center justify-between">
              <div className="flex items-center gap-2.5">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <circle cx="16" cy="16" r="16" fill="white" fill-opacity="0.04" />
                  <path d="M15.3274 17.8701C15.9976 17.4239 16.5063 16.774 16.7785 16.0163C17.0507 15.2587 17.0718 14.4336 16.8387 13.663C16.6057 12.8924 16.1309 12.2173 15.4844 11.7374C14.838 11.2576 14.0543 10.9985 13.2493 10.9985C12.4443 10.9985 11.6606 11.2576 11.0142 11.7374C10.3677 12.2173 9.8929 12.8924 9.65986 13.663C9.42681 14.4336 9.44794 15.2587 9.72011 16.0163C9.99228 16.774 10.501 17.4239 11.1712 17.8701C9.95898 18.3168 8.92374 19.1436 8.21992 20.2269C8.18293 20.2819 8.15724 20.3437 8.14434 20.4087C8.13143 20.4737 8.13158 20.5406 8.14476 20.6055C8.15795 20.6705 8.18391 20.7321 8.22113 20.787C8.25836 20.8418 8.30611 20.8886 8.36161 20.9248C8.41711 20.961 8.47926 20.9858 8.54443 20.9978C8.6096 21.0098 8.6765 21.0087 8.74125 20.9946C8.80599 20.9805 8.86728 20.9536 8.92156 20.9156C8.97584 20.8776 9.02202 20.8292 9.05742 20.7732C9.51142 20.0749 10.1326 19.5011 10.8647 19.1039C11.5967 18.7067 12.4164 18.4987 13.2493 18.4987C14.0822 18.4987 14.9019 18.7067 15.6339 19.1039C16.366 19.5011 16.9872 20.0749 17.4412 20.7732C17.5145 20.8822 17.6278 20.9579 17.7565 20.9841C17.8853 21.0102 18.0191 20.9846 18.1292 20.9129C18.2392 20.8411 18.3166 20.7289 18.3445 20.6005C18.3725 20.4722 18.3489 20.338 18.2787 20.2269C17.5749 19.1436 16.5396 18.3168 15.3274 17.8701ZM10.4993 14.7501C10.4993 14.2062 10.6606 13.6745 10.9628 13.2222C11.2649 12.77 11.6944 12.4175 12.1969 12.2094C12.6994 12.0012 13.2523 11.9468 13.7858 12.0529C14.3192 12.159 14.8092 12.4209 15.1938 12.8055C15.5784 13.1901 15.8403 13.6801 15.9465 14.2136C16.0526 14.747 15.9981 15.2999 15.79 15.8024C15.5818 16.3049 15.2294 16.7344 14.7771 17.0366C14.3249 17.3388 13.7932 17.5001 13.2493 17.5001C12.5202 17.4992 11.8212 17.2092 11.3057 16.6937C10.7901 16.1781 10.5001 15.4791 10.4993 14.7501ZM23.633 20.9188C23.522 20.9912 23.3867 21.0166 23.257 20.9893C23.1272 20.962 23.0136 20.8842 22.9412 20.7732C22.4877 20.0745 21.8666 19.5005 21.1344 19.1034C20.4022 18.7064 19.5822 18.4989 18.7493 18.5001C18.6167 18.5001 18.4895 18.4474 18.3957 18.3536C18.302 18.2598 18.2493 18.1327 18.2493 18.0001C18.2493 17.8674 18.302 17.7403 18.3957 17.6465C18.4895 17.5527 18.6167 17.5001 18.7493 17.5001C19.1543 17.4997 19.5542 17.4099 19.9204 17.237C20.2867 17.0642 20.6102 16.8126 20.8679 16.5002C21.1257 16.1878 21.3112 15.8223 21.4113 15.4299C21.5115 15.0375 21.5237 14.6278 21.4471 14.2301C21.3705 13.8325 21.2071 13.4566 20.9684 13.1294C20.7298 12.8022 20.4218 12.5318 20.0665 12.3375C19.7112 12.1431 19.3174 12.0296 18.9131 12.0051C18.5089 11.9806 18.1042 12.0457 17.728 12.1957C17.6667 12.2222 17.6007 12.2361 17.5339 12.2367C17.4671 12.2373 17.4008 12.2244 17.339 12.199C17.2773 12.1735 17.2212 12.1359 17.1742 12.0884C17.1272 12.0409 17.0902 11.9845 17.0654 11.9224C17.0406 11.8604 17.0285 11.794 17.0297 11.7272C17.031 11.6604 17.0457 11.5945 17.0728 11.5335C17.1 11.4724 17.1391 11.4174 17.1879 11.3718C17.2367 11.3261 17.2941 11.2907 17.3568 11.2676C18.2177 10.9242 19.1753 10.9119 20.0448 11.2329C20.9142 11.5539 21.634 12.1855 22.0653 13.0059C22.4966 13.8264 22.6087 14.7774 22.3801 15.6756C22.1515 16.5739 21.5984 17.3556 20.8274 17.8701C22.0396 18.3168 23.0749 19.1436 23.7787 20.2269C23.8511 20.338 23.8764 20.4733 23.8491 20.603C23.8218 20.7328 23.7441 20.8464 23.633 20.9188Z" fill="white" />
                </svg>

                <span className="text-white font-medium text-sm flex items-center gap-5">Dar permissão para outro membro</span>
              </div>
              <button onClick={() => setModalVisible(prevState => !prevState)} className="h-7 px-3 flex items-center rounded-[.3125rem] font-medium text-white bg-white/[0.04]">Ver membros</button>
            </div>
          </div>
          <button onClick={() => properties.rent_price && fetch('PAY_RENT_PROPERTY', properties.id)} className={clsx('h-10 px-3 rounded-[.3125rem] font-medium text-white text-center bg-white/5 cursor-default', properties.rent_price && 'bg-gradient-to-r from-primary-500 to-primary-600 !cursor-pointer')}>
            {
              properties.rent_price
                ? <span>Pagar aluguel R$ { new Intl.NumberFormat('en-DE').format(properties.rent_price) }</span>
                : <span>Aluguel pago</span>
            }
          </button>
        </div>
      </div>
      { modalVisible && <ModalMembers property={properties.id} onClose={() => setModalVisible(false)} max_members={properties.max_members} members={properties.members} /> }
    </>
  )
}