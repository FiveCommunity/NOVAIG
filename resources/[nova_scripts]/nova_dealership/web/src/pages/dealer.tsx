import Header from '@/components/header'
import { ChevronLeft, Search } from 'lucide-react'
import { motion } from 'framer-motion'
import { clsx } from 'clsx'
import { useState, useRef, useEffect } from 'react'
import { emit } from '@/utils/emit'
import aceleration from '../assets/aceleration.svg'
import value from '../assets/value.svg'
import debounce from '../assets/debounce.svg'
import seats from '../assets/seats.svg'
import defaultVehicle from '../assets/default_vehicle.webp'
import success from '../assets/success.svg'
import { ColorPicker } from 'antd'
import trunk from '../assets/trunk.svg'

interface IVehicle {
  name: string
  value: number
  image: string
  acceleration: string
  speed: number
  seats: number
  trunk: number
  stock: number
  category: string
}

export default function Dealer() {
  const [vehicles, setVehicles] = useState<IVehicle[]>([])
  const [selectedVehicle, setSelectedVehicle] = useState<IVehicle | null>(null)
  const inputRef = useRef<HTMLInputElement>(null)
  const [filteredVehicles, setFilteredVehicles] = useState<IVehicle[]>([])
  const [myVehicles, setMyVehicles] = useState<
    Omit<IVehicle, 'category' | 'stock'>[]
  >([])
  const [modalVisible, setModalVisible] = useState(false)
  const [color, setColor] = useState<string>('#8e1e1e')
  const [category, setCategory] = useState<string>('esportivos')

  function convertHexToRgba(hex: string) {
    return `rgba(${parseInt(hex.slice(1, 3), 16)}, ${parseInt(hex.slice(3, 5), 16)}, ${parseInt(hex.slice(5, 7), 16)}, 1)`
  }

  useEffect(() => {
    emit<IVehicle[]>('GET_VEHICLES', {}, [
      {
        name: 'Kawasaki Ninja H2R',
        value: 150000,
        image: '/vehicle.png',
        acceleration: 'Boa',
        speed: 400,
        seats: 1,
        trunk: 35,
        stock: 5,
        category: 'esportivos',
      },
      {
        name: 'Ducati Panigale V4',
        value: 120000,
        image: '/vehicle.png',
        acceleration: 'Boa',
        speed: 350,
        seats: 1,
        trunk: 0,
        stock: 3,
        category: 'vips',
      },
      {
        name: 'BMW S1000RR',
        value: 110000,
        image: '/vehicle.png',
        acceleration: 'Boa',
        speed: 330,
        seats: 1,
        trunk: 0,
        stock: 4,
        category: 'motos',
      },
      {
        name: 'Ferrari F8 Tributo',
        value: 3500000,
        image: '/vehicle.png',
        acceleration: 'Excelente',
        speed: 340,
        seats: 2,
        trunk: 2,
        stock: 2,
        category: 'esportivos',
      },
      {
        name: 'Porsche 911 GT3 RS',
        value: 2800000,
        image: '/vehicle.png',
        acceleration: 'Excelente',
        speed: 320,
        seats: 2,
        trunk: 2,
        stock: 3,
        category: 'esportivos',
      },
      {
        name: 'Mercedes-Benz S-Class',
        value: 950000,
        image: '/vehicle.png',
        acceleration: 'Muito Boa',
        speed: 250,
        seats: 5,
        trunk: 4,
        stock: 4,
        category: 'sedan',
      },
      {
        name: 'BMW X7',
        value: 1200000,
        image: '/vehicle.png',
        acceleration: 'Muito Boa',
        speed: 230,
        seats: 7,
        trunk: 6,
        stock: 3,
        category: 'outros',
      },
      {
        name: 'Land Rover Defender',
        value: 850000,
        image: '/vehicle.png',
        acceleration: 'Boa',
        speed: 190,
        seats: 5,
        trunk: 5,
        stock: 5,
        category: 'off-roads',
      },
      {
        name: 'Volvo FH16',
        value: 980000,
        image: '/vehicle.png',
        acceleration: 'Moderada',
        speed: 160,
        seats: 2,
        trunk: 50,
        stock: 8,
        category: 'caminhoes',
      },
      {
        name: 'Cessna Citation X',
        value: 15000000,
        image: '/vehicle.png',
        acceleration: 'Excelente',
        speed: 980,
        seats: 12,
        trunk: 8,
        stock: 1,
        category: 'meus-veiculos',
      },
    ]).then((vehicles) => {
      setVehicles(vehicles)
      setFilteredVehicles(vehicles)
    })

    emit<Omit<IVehicle, 'category' | 'stock'>[]>('GET_MY_VEHICLES', {}, [
      {
        name: 'Kawasaki Ninja H2R',
        value: 150000,
        image: '/vehicle.png',
        acceleration: 'Boa',
        speed: 400,
        seats: 1,
        trunk: 35,
      },
    ]).then((vehicles) => {
      setMyVehicles(vehicles)
    })
  }, [])

  function handleBuy() {
    emit(
      'CAN_BUY',
      {
        vehicle: selectedVehicle,
        color: convertHexToRgba(color),
      },
      true,
    ).then((data) => {
      if (data) {
        setModalVisible(true)
      }
    })
  }

  function handleSearch() {
    if (!inputRef.current) return

    setFilteredVehicles(
      vehicles.filter((vehicle) =>
        vehicle.name
          .toLowerCase()
          .includes(inputRef.current!.value.toLowerCase()),
      ),
    )
    inputRef.current.value = ''
  }

  return (
    <div className="w-[100.625rem] h-[53.125rem] bg-background bg-center bg-cover p-10 space-y-[2.56rem]">
      <Header category={category} setCategory={setCategory} />
      <div>
        <div>
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="flex items-center gap-2"
          >
            <motion.div
              onClick={() => setSelectedVehicle(null)}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              className="w-[5.625rem] h-[2.1875rem] muted-foreground flex items-center justify-center gap-2 cursor-pointer"
            >
              <ChevronLeft className="size-[0.75rem] text-white/50" />
              <p className="text-white/50">Voltar</p>
            </motion.div>
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5, delay: 0.2 }}
              className="w-[81.5rem] h-[2.1875rem] px-3 muted-foreground relative"
            >
              <input
                ref={inputRef}
                type="text"
                className="w-full h-full px-3 bg-transparent border-none placeholder:text-white/50 text-white text-sm"
                placeholder="INFORME O NOME"
              />
              <Search className="size-[1.25rem] text-white/50 absolute right-3 top-1" />
            </motion.div>
            <motion.button
              onClick={handleSearch}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5, delay: 0.4 }}
              className="accent h-[2.1875rem] w-[7.5rem] text-sm text-white font-bold uppercase"
            >
              BUSCAR
            </motion.button>
          </motion.div>
          <div className="flex gap-[1.87rem]">
            <motion.div
              initial={{ opacity: 0, x: -50 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.5 }}
              className={clsx('w-[54.875rem] relative', {
                hidden: !selectedVehicle,
              })}
            >
              {selectedVehicle &&
                selectedVehicle.category !== 'meus-veiculos' && (
                  <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ duration: 0.5 }}
                    className="space-y-1 absolute top-20"
                  >
                    <p className="text-xs text-white font-bold">
                      Cor do veículo:
                    </p>
                    <ColorPicker
                      format="rgb"
                      onFormatChange={(value) => setColor(value || '#8e1e1e')}
                    />{' '}
                  </motion.div>
                )}
              <motion.p
                initial={{ opacity: 0, y: -20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.3 }}
                className="text-white text-[3.4375rem] font-bold uppercase"
              >
                {selectedVehicle?.name}
              </motion.p>
              <motion.img
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.5, delay: 0.2 }}
                src={debounce}
                className="h-[25rem] absolute left-1/2 -translate-x-1/2"
                alt=""
              />
              <motion.img
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ duration: 0.5, delay: 0.4 }}
                src={selectedVehicle?.image}
                onError={(e) => {
                  e.currentTarget.src = defaultVehicle
                }}
                className="h-[17.125rem] absolute left-1/2 top-[9rem] -translate-x-1/2"
                alt=""
              />
              <motion.div
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.5, delay: 0.6 }}
                className="absolute bottom-0 w-full h-[10.625rem]"
              >
                <div className="flex w-full justify-between">
                  <motion.div
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.3, delay: 0.7 }}
                    className="flex gap-3"
                  >
                    {selectedVehicle?.category !== 'meus-veiculos' && (
                      <>
                        <img className="size-[3.4375rem]" src={value} alt="" />

                        <div className="">
                          <p className="text-white/50 text-sm">Valor</p>
                          <p className="text-white text-[1.875rem] leading-[1.5rem] font-bold">
                            R${selectedVehicle?.value.toLocaleString('pt-BR')}
                          </p>
                        </div>
                      </>
                    )}
                  </motion.div>
                  <motion.div
                    initial={{ opacity: 0, x: 20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.3, delay: 0.7 }}
                    className="flex items-center gap-3"
                  >
                    {category !== 'meus-veiculos' && (
                      <motion.button
                        onClick={() =>
                          emit('TEST_DRIVE', { vehicle: selectedVehicle })
                        }
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.95 }}
                        className="w-[11.25rem] h-[3.125rem] muted-foreground font-bold uppercase text-white/70"
                      >
                        TEST-DRIVE
                      </motion.button>
                    )}
                    {(category === 'meus-veiculos' || category !== 'vips') && (
                      <motion.button
                        onClick={() => {
                          if (category === 'meus-veiculos') {
                            emit('SELL_VEHICLE', { vehicle: selectedVehicle })
                          } else {
                            handleBuy()
                          }
                        }}
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.95 }}
                        className="w-[11.25rem] h-[3.125rem] buy font-bold uppercase text-white"
                      >
                        {category === 'meus-veiculos' ? 'VENDER' : 'COMPRAR'}
                      </motion.button>
                    )}
                  </motion.div>
                </div>
                <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.5, delay: 0.8 }}
                  className="w-full flex items-center px-5 h-[6.875rem] border border-white/15 mt-3"
                  style={{
                    background:
                      'radial-gradient(71.05% 71.05% at 50% 50%, rgba(255, 255, 255, 0.10) 0%, rgba(221, 221, 221, 0.00) 100%)',
                  }}
                >
                  <div className="flex items-center gap-2 w-[14.25rem]">
                    <img
                      className="size-[2.8125rem]"
                      src={aceleration}
                      alt=""
                    />
                    <div>
                      <p className="text-white/50 text-sm relative z-20 uppercase">
                        Aceleração
                      </p>
                      <p className="text-white text-[1.75rem] font-bold uppercase leading-[1rem] relative z-10">
                        {selectedVehicle?.acceleration}
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 w-[12.625rem]">
                    <img className="size-[2.8125rem]" src={trunk} alt="" />
                    <div>
                      <p className="text-white/50 text-sm relative z-20 uppercase">
                        Porta Malas
                      </p>
                      <p className="text-white text-[1.75rem] font-bold uppercase leading-[1rem] relative z-10">
                        {selectedVehicle?.trunk}KG
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2 w-[15.5rem]">
                    <img
                      className="size-[2.8125rem]"
                      src={aceleration}
                      alt=""
                    />
                    <div>
                      <p className="text-white/50 text-sm relative z-20 uppercase">
                        Velocidade
                      </p>
                      <p className="text-white text-[1.75rem] font-bold uppercase leading-[1rem] relative z-10">
                        {selectedVehicle?.speed}KM/H
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <img className="size-[2.8125rem]" src={seats} alt="" />
                    <div>
                      <p className="text-white/50 text-sm relative z-20 uppercase">
                        Assentos
                      </p>
                      <p className="text-white text-[1.75rem] font-bold uppercase leading-[1rem] relative z-10">
                        {selectedVehicle?.seats}
                      </p>
                    </div>
                  </div>
                </motion.div>
              </motion.div>
            </motion.div>
            <div
              className={clsx(
                'w-full grid grid-cols-5 gap-2.5 mt-2.5 h-[42.1875rem] overflow-y-auto pr-1 overflow-x-hidden',
                {
                  '!w-[38.6875rem] !grid-cols-2': selectedVehicle,
                },
              )}
            >
              {category === 'meus-veiculos'
                ? myVehicles.map((vehicle, index) => {
                    return (
                      <motion.div
                        key={index}
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.5, delay: index * 0.1 }}
                        className="muted-foreground flex-none h-[16.25rem] w-[18.6rem] relative"
                      >
                        <p className="text-white text-sm absolute top-5 left-5 uppercase font-bold">
                          {vehicle.name}
                        </p>

                        <img
                          src={debounce}
                          alt=""
                          className="absolute top-1/2 left-1/2 max-h-[8.125rem] -translate-x-1/2 -translate-y-1/2 object-cover"
                        />
                        <img
                          src={vehicle.image}
                          alt=""
                          onError={(e) => {
                            e.currentTarget.src = defaultVehicle
                          }}
                          className="absolute top-1/2 left-1/2 max-h-[5.8rem] -translate-x-1/2 -translate-y-1/2 object-cover"
                        />
                        <div className="space-y-4 w-full absolute left-1/2 -translate-x-1/2 bottom-2.5 px-5">
                          <div className="flex items-center w-full justify-between">
                            <p className="text-white/70 font-bold">
                              R${vehicle.value.toLocaleString('pt-BR')}
                            </p>
                          </div>
                          <motion.button
                            onClick={() =>
                              setSelectedVehicle(vehicle as IVehicle)
                            }
                            whileHover={{ scale: 1.05 }}
                            whileTap={{ scale: 0.95 }}
                            className={clsx(
                              'muted-foreground w-full h-[2.5rem] text-sm text-white/70 font-bold uppercase',
                              {
                                accent: selectedVehicle?.name === vehicle.name,
                              },
                            )}
                          >
                            DETALHES
                          </motion.button>
                        </div>
                      </motion.div>
                    )
                  })
                : filteredVehicles
                    ?.filter((vehicle) => vehicle.category === category)
                    .map((vehicle, index) => {
                      return (
                        <motion.div
                          key={index}
                          initial={{ opacity: 0, y: 20 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ duration: 0.5, delay: index * 0.1 }}
                          className="muted-foreground flex-none h-[16.25rem] w-[18.6rem] relative"
                        >
                          <p className="text-white text-sm absolute top-5 left-5 uppercase font-bold">
                            {vehicle.name}
                          </p>

                          <img
                            src={debounce}
                            alt=""
                            className="absolute top-1/2 left-1/2 max-h-[8.125rem] -translate-x-1/2 -translate-y-1/2 object-cover"
                          />
                          <img
                            src={vehicle.image}
                            alt=""
                            onError={(e) => {
                              e.currentTarget.src = defaultVehicle
                            }}
                            className="absolute top-1/2 left-1/2 max-h-[5.8rem] -translate-x-1/2 -translate-y-1/2 object-cover"
                          />
                          <div className="space-y-4 w-full absolute left-1/2 -translate-x-1/2 bottom-2.5 px-5">
                            <div className="flex items-center w-full justify-between">
                              <p className="text-white/70 font-bold">
                                R${vehicle.value.toLocaleString('pt-BR')}
                              </p>
                              <p className="text-white/40">{vehicle.stock}</p>
                            </div>
                            <motion.button
                              onClick={() => setSelectedVehicle(vehicle)}
                              whileHover={{ scale: 1.05 }}
                              whileTap={{ scale: 0.95 }}
                              className={clsx(
                                'muted-foreground w-full h-[2.5rem] text-sm text-white/70 font-bold uppercase',
                                {
                                  accent:
                                    selectedVehicle?.name === vehicle.name,
                                },
                              )}
                            >
                              DETALHES
                            </motion.button>
                          </div>
                        </motion.div>
                      )
                    })}
            </div>
          </div>
        </div>
      </div>
      {modalVisible && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.3 }}
          className={clsx(
            'absolute w-full h-full bg-black/60 flex items-center justify-center left-0 bottom-0',
            {
              hidden: !modalVisible,
            },
          )}
        >
          <motion.div
            initial={{ scale: 0.5, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="w-[23.125rem] h-[22.125rem] muted-foreground flex flex-col items-center py-[2.5rem]"
          >
            <motion.img
              initial={{ scale: 0, rotate: -180 }}
              animate={{ scale: 1, rotate: 0 }}
              transition={{ duration: 0.5, delay: 0.4 }}
              className="size-[6.875rem]"
              src={success}
              alt=""
            />
            <motion.h6
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3, delay: 0.6 }}
              className="text-white text-[1.875rem] font-bold"
            >
              SUCESSO
            </motion.h6>
            <motion.p
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3, delay: 0.7 }}
              className="text-white/50 text-center"
            >
              VOCÊ REALIZOU A COMPRA DE UM VEÍCULO
              <br />
              <span className="font-bold text-white">
                {selectedVehicle?.name}
              </span>{' '}
              POR{' '}
              <span className="font-bold text-white">
                R${selectedVehicle?.value.toLocaleString('pt-BR')}
              </span>
            </motion.p>
            <motion.button
              onClick={() => {
                setModalVisible(false)
                setSelectedVehicle(null)
              }}
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.3, delay: 0.8 }}
              className="buy w-[18.125rem] mt-6 h-[3.125rem] text-sm text-white font-bold uppercase"
            >
              CONFIRMAR
            </motion.button>
          </motion.div>
        </motion.div>
      )}
    </div>
  )
}
