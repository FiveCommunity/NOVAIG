import { Navigate, Route, Routes } from 'react-router-dom'
import Home from './pages/Home'
import { VisibilityProvider } from './providers/Visibility'
import clsx from 'clsx'
import { isEnvBrowser } from './utils/misc'
import Background from './assets/background.png'
import Store from './pages/Store'

export default function App() {
  return (
    <VisibilityProvider>
      <div
        className={clsx('w-screen h-screen', {
          'bg-zinc-800': isEnvBrowser(),
        })}
        style={{
          backgroundImage: `url(${Background})`,
          backgroundSize: 'cover',
          backgroundPosition: 'center',
          backgroundRepeat: 'no-repeat',
        }}
      >
        <div className="w-full h-full" id="interface">
          <Routes>
            <Route path="/store" element={<Store />} />
            <Route path="/home" element={<Home />} />
            <Route path="*" element={<Navigate to="/home" />} />
          </Routes>
        </div>
      </div>
    </VisibilityProvider>
  )
}
