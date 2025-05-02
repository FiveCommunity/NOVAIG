import Header from '@/components/header'
import { ChevronLeft, Search } from 'lucide-react'
import { motion } from 'framer-motion'
import { clsx } from 'clsx'
import { useState, useRef, useEffect } from 'react'
import { emit } from '@/utils/emit'
import debounce from '../assets/debounce.svg'
import defaultVehicle from '../assets/default_vehicle.webp'
import success from '../assets/success.svg'
import { ColorPicker } from 'antd'

interface IVehicle {
  name: string
  value: number
  image: string
  stock: number
}

export default function Home() {
  const [vehicles, setVehicles] = useState<IVehicle[]>([])
  const [selectedVehicle, setSelectedVehicle] = useState<IVehicle | null>(null)
  const inputRef = useRef<HTMLInputElement>(null)
  const [filteredVehicles, setFilteredVehicles] = useState<IVehicle[]>([])
  const [modalVisible, setModalVisible] = useState(false)
  const [category, setCategory] = useState<string>('')
  const [color, setColor] = useState<string>('#8e1e1e')

  function convertHexToRgba(hex: string) {
    return `rgba(${parseInt(hex.slice(1, 3), 16)}, ${parseInt(hex.slice(3, 5), 16)}, ${parseInt(hex.slice(5, 7), 16)}, 1)`
  }

  useEffect(() => {
    emit<IVehicle[]>('GET_MOST_SOLD', {}, [
      {
        name: 'Kawasaki Ninja H2R',
        value: 150000,
        image: '/sdfdgsdgsd.png',
        stock: 5,
      },
      {
        name: 'Ducati Panigale V4',
        value: 120000,
        image: '/vehicle.png',
        stock: 3,
      },
      {
        name: 'BMW S1000RR',
        value: 135000,
        image: '/vehicle.png',
        stock: 4,
      },
      {
        name: 'Yamaha R1',
        value: 110000,
        image: '/vehicle.png',
        stock: 6,
      },
    ]).then((vehicles) => {
      setVehicles(vehicles)
      setSelectedVehicle(vehicles[0])
      setFilteredVehicles(vehicles)
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
              className={clsx('w-[54.875rem] relative')}
            >
              {selectedVehicle && (
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
                className="h-[25rem] absolute left-1/2 -translate-x-1/2 top-[8rem]"
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
                className="h-[17.125rem] absolute left-1/2 top-[14rem] -translate-x-1/2"
                alt=""
              />
            </motion.div>
            <div>
              <p className="text-white text-[1.1875rem] font-bold -mb-2 mt-3">
                TOP 4 MAIS VENDIDOS
              </p>
              <div
                className={clsx(
                  'w-[38.6875rem] gap-2 self-start content-start flex flex-wrap mt-2.5 overflow-y-hidden pr-1 overflow-x-hidden',
                )}
              >
                {filteredVehicles.map((vehicle, index) => {
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
                        src="./debounce.svg"
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
                              accent: selectedVehicle?.name === vehicle.name,
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
              {selectedVehicle && (
                <button
                  onClick={handleBuy}
                  className="buy w-[37.6875rem] mt-6 h-[3.125rem] text-sm text-white font-bold uppercase self-center"
                >
                  COMPRAR
                </button>
              )}
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
