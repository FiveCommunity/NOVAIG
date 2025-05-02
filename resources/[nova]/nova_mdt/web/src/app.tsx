import { Navigate, Route, Routes } from 'react-router-dom'
import Home from './pages/Home'
import { isEnvBrowser } from './utils/misc'
import { VisibilityProvider } from './providers/Visibility'
import clsx from 'clsx'
import toast, { Toaster } from 'react-hot-toast'
import { observe } from './hooks/observe'
import Mockup from './assets/mockup.png'
import Aside from './components/aside'
import Search from './pages/Search'
import User from './pages/User'
import Vehicle from './pages/Vehicle'
import ReportCard from './pages/ReportCard'
import SearchArrest from './pages/SearchArrest'
import Arrest from './pages/Arrest'
import History from './pages/History'
import Config from './pages/Config'

export default function App() {
  observe('showToast', (data: string) => {
    toast(data, {
      icon: '✉️',
    })
  })

  return (
    <VisibilityProvider>
      <div
        className={clsx(
          'w-screen h-screen grid place-items-center',
          isEnvBrowser() && 'bg-zinc-700',
        )}
      >
        <div
          id="interface"
          className="w-[85.75rem] h-[47rem] bg-center bg-cover py-[5.06rem] px-[5.69rem]"
          style={{ backgroundImage: `url('${Mockup}')` }}
        >
          <div className="flex gap-4">
            <Aside />
            <Routes>
              <Route path="/config" element={<Config />} />
              <Route path="/history" element={<History />} />
              <Route path="/arrest" element={<Arrest />} />
              <Route path="/searcharrest" element={<SearchArrest />} />
              <Route path="/reportcard" element={<ReportCard />} />
              <Route path="/vehicle" element={<Vehicle />} />
              <Route path="/user" element={<User />} />
              <Route path="/search" element={<Search />} />
              <Route path="/home" element={<Home />} />
              <Route path="*" element={<Navigate to="/home" />} />
            </Routes>
          </div>
        </div>
      </div>
      <Toaster position="top-center" reverseOrder={false} />
    </VisibilityProvider>
  )
}
