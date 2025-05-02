import { isEnvBrowser } from './utils/misc'
import clsx from 'clsx'
import { Route, Routes } from 'react-router-dom'
import Dealer from './pages/dealer'
import Home from './pages/home'
import { VisibilityProvider } from './providers/Visibility'

export default function App() {
  return (
    <VisibilityProvider>
      <div
      className={clsx(
        'w-screen h-screen antialiased flex items-center justify-center flex-col gap-4',
        isEnvBrowser() && 'bg-zinc-700',
      )}
    >
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/dealer" element={<Dealer />} />
        <Route path="*" element={<Home />} />
        </Routes>
      </div>
    </VisibilityProvider>
  )
}
