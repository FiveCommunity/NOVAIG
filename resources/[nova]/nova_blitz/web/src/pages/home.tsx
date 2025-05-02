import { emit } from '@/utils/emit'
import { motion } from 'framer-motion'

export default function Home() {
  const items = [
    {
      title: 'MURO COM FAIXA',
      image: './wall.png',
      item: 'wall',
    },
    {
      title: 'MURO SEM FAIXA',
      image: './wall2.png',
      item: 'wall2',
    },
    {
      title: 'CONE',
      image: './cone.png',
      item: 'cone',
    },
    {
      title: 'CONE ALTO',
      image: './high-cone.png',
      item: 'high-cone',
    },
    {
      title: 'CONE REDONDO',
      image: './rounded-cone.png',
      item: 'rounded-cone',
    },
    {
      title: 'PREGOS',
      image: './nails.png',
      item: 'nails',
    },
    {
      title: 'BARRICADA',
      image: './barricade.png',
      item: 'barricade',
    },
    {
      title: 'BARRICADA 2',
      image: './barricade2.png',
      item: 'barricade2',
    },
  ]

  return (
    <motion.div
      initial={{ opacity: 0, scale: 0.9 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ duration: 0.6 }}
      className="w-[73.75rem] h-[45.625rem] rounded bg-center bg-cover bg-no-repeat bg-background p-[2.19rem]"
    >
      <motion.div
        initial={{ y: -20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ delay: 0.2 }}
        className="flex items-center justify-between"
      >
        <motion.img
          whileHover={{ scale: 1.05 }}
          className="h-[3.5625rem]"
          src="./title.png"
          alt=""
        />
        <motion.img
          onClick={() => emit('CLOSE', {})}
          whileHover={{ scale: 1.1, rotate: 5 }}
          className="h-[2.1rem] cursor-pointer"
          src="./exit.png"
          alt=""
        />
      </motion.div>
      <motion.div
        initial={{ y: 20, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        transition={{ delay: 0.4 }}
        className="mt-[2.13rem] gap-2 flex flex-wrap"
      >
        {items.map((item, key) => {
          return (
            <motion.div
              key={key}
              whileHover={{ scale: 1.02 }}
              transition={{ type: 'spring', stiffness: 400 }}
              className="flex w-[16.875rem] h-[17.5rem] item relative p-5 flex-none"
            >
              <motion.p
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.6 }}
                className="text-white font-semibold"
              >
                {item.title}
              </motion.p>
              <motion.img
                transition={{ delay: 0.8, type: 'spring' }}
                className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 h-[9.375rem]"
                src={item.image}
                alt=""
              />
              <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 1 }}
                className="absolute left-1/2 bottom-5 -translate-x-1/2 flex items-center gap-2"
              >
                <motion.button
                  onClick={() => emit('REMOVE_ITEM', item.item)}
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.95 }}
                  className="w-[6.9rem] h-[2.5rem] rounded item text-white/50 font-semibold"
                >
                  REMOVER
                </motion.button>
                <motion.button
                  onClick={() => emit('PUT_ITEM', item.item)}
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.95 }}
                  className="w-[6.9rem] h-[2.5rem] rounded accent text-white font-semibold"
                >
                  COLOCAR
                </motion.button>
              </motion.div>
            </motion.div>
          )
        })}
      </motion.div>
    </motion.div>
  )
}
