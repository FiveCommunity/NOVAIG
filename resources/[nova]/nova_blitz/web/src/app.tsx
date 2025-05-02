import { isEnvBrowser } from './utils/misc'
import clsx from 'clsx'
import Home from './pages/home'

export default function App() {
  return (
    <div
      className={clsx(
        'w-screen h-screen antialiased flex items-center justify-center flex-col gap-4',
        isEnvBrowser() && 'bg-zinc-700',
      )}
    >
      <Home />
    </div>
  )
}
