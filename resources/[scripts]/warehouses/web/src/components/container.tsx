import { Header } from './header'

export function Container({ children }: { children: React.ReactNode }) {
  return (
    <div className="w-screen h-screen absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 select-none grid place-items-center ">
      <div className="max-w-[66.25rem] w-full max-h-[40.75rem] h-full bg-neutral-500 rounded-xl p-3 flex flex-col gap-3">
        <Header />
        { children }
      </div>
    </div>
  )
}