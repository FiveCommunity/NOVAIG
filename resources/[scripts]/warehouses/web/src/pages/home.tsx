import { Swiper, SwiperSlide } from 'swiper/react'



export function HomePage() {
  return (
    <div className="flex gap-3 max-h-full overflow-hidden">
      <img className="" src="/01.png" alt="" />
      <div className="w-full flex flex-col max-w-full overflow-hidden">
        <div className="rounded-lg p-5 bg-neutral-600 flex flex-col gap-4">
          <span className="bg-white/5 uppercase text-white h-[2.1875rem] px-5 rounded-[.3125rem] font-medium text-lg flex items-center leading-none">O que é o programa minha casa minha vida?</span>
          <p className="text-white/45 text-sm">
            O programa Minha Casa Minha Vida consiste no aluguel de apartamentos já de padrão com capacidade para até 500kg de bagagem (podendo ser ampliada). O valor do aluguel deve ser pago a cada 7 dias, e a primeira parcela do aluguel é equivalente a 3 vezes o valor do aluguel mensal. É uma oportunidade oferecida pelo governo da sua cidade para garantir um apartamento espaçoso e de qualidade.
            <br />
            <br />
            <b className="text-white/85 font-semibold">Além disso, o programa oferece os seguintes benefícios:</b>
            <br />
            <br />
            Subsídio governamental: O governo subsidia parte do valor do aluguel para você. Prazo de aluguel estendido: Os participantes do programa podem atrasar o pagamento do aluguel por até 3 dias Entrada facilitada: É possível dar entrada no imóvel com seus recursos O programa Minha Casa Minha Vida é uma excelente opção para você que busca um apartamento de qualidade a um preço acessível.
          </p>
        </div>

        <Swiper className="max-w-full" spaceBetween={12} slidesPerView={"auto"}>
          <SwiperSlide className="!w-fit">
            <img className="h-full w-fit" src="/02.png" />
          </SwiperSlide>
          <SwiperSlide className="!w-fit">
            <img className="h-full w-fit" src="/03.png" />
          </SwiperSlide>
        </Swiper>
        <div className="flex gap-3 max-h-full overflow-hidden">
        </div>
      </div>
    </div>
  )
}