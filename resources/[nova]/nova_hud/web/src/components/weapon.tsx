interface IWeapon {
  image: string
  current: number
  max: number
}

export default function Weapon({ image, current, max }: IWeapon) {
  return (
    <div className="flex items-end flex-col gap-[.19rem]">
      <div className="size-8 flex items-center justify-center bg-primary rounded-full">
        <img src={'./icons/bullets.svg'} className="size-1/2"/>
      </div>
      <div className="h-[1.875rem] flex-none bg-black-500 flex items-center justify-center rounded-sm px-[.38rem]">
        <p className="text-white/75 text-sm font-normal"><b className="text-white">{current}</b>/{max}</p>
      </div>
    </div>
  )
}