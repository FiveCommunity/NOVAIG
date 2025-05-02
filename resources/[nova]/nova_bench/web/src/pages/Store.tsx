import { ItemProps } from '@/interfaces/interface'
import { useEffect, useState } from 'react'
import Ilegal from '../assets/ilegal.svg'
import { emit } from '@/utils/emit'
import ItemSell from '@/components/item-sell'
import { observe } from '@/hooks/observe'

export default function Store() {
  const [products, setProducts] = useState<ItemProps[]>([])

  useEffect(() => {
    emit<ItemProps[]>('GET_PRODUCTS', {}, [
      {
        amount: 1,
        image:
          'https://cdn.shopify.com/s/files/1/0533/2089/5885/products/product-image-1175360001_360x.jpg?v=1623860000',
        name: 'Coca-Cola',
        value: 5.0,
        weight: 0.5,
      },
      {
        amount: 1,
        image:
          'https://cdn.shopify.com/s/files/1/0533/2089/5885/products/product-image-1175360001_360x.jpg?v=1623860000',
        name: 'Coca-Cola',
        value: 5.0,
        weight: 0.5,
      },
      {
        amount: 1,
        image:
          'https://cdn.shopify.com/s/files/1/0533/2089/5885/products/product-image-1175360001_360x.jpg?v=1623860000',
        name: 'Coca-Cola',
        value: 5.0,
        weight: 0.5,
      },
      {
        amount: 1,
        image:
          'https://cdn.shopify.com/s/files/1/0533/2089/5885/products/product-image-1175360001_360x.jpg?v=1623860000',
        name: 'Coca-Cola',
        value: 5.0,
        weight: 0.5,
      },
      {
        amount: 1,
        image:
          'https://cdn.shopify.com/s/files/1/0533/2089/5885/products/product-image-1175360001_360x.jpg?v=1623860000',
        name: 'Coca-Cola',
        value: 5.0,
        weight: 0.5,
      },
    ]).then((res) => {
      setProducts(res)
    })
    
  }, [])

  observe('UPDATE_STORE', setProducts)


  return (
    <div className="w-full h-full flex flex-col gap-4  justify-center px-11">
      <img className="w-[9rem]" src={Ilegal} alt="" />
      <div className="flex flex-col gap-2.5 overflow-y-auto w-[27.5rem] h-[40rem]">
        {products.map((product, index) => (
          <ItemSell item={product} key={index} />
        ))}
      </div>
    </div>
  )
}
