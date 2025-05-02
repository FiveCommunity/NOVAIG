import React, {
  Context,
  createContext,
  useContext,
  useEffect,
  useState,
} from 'react'
import { isEnvBrowser } from '../utils/misc'
import { observe } from '../hooks/observe'
import { emit } from '../utils/emit'
import { useNavigate } from 'react-router-dom'
import { useNui } from '@/store/useNui'

interface VisibilityProviderValue {}

const VisibilityContext = createContext<VisibilityProviderValue | null>(null)

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [visible, setVisible] = useState(isEnvBrowser())
  const { setUser, setOrg, setCrimes, setMitigatingFactors } = useNui()
  const navigate = useNavigate()

  observe('open', (data) => {
    navigate('/')

    setVisible(true)
    setUser(data.user)
    setOrg(data.org)

    setCrimes(data.crimes)
    setMitigatingFactors(data.mitigatingFactors)
  })

  observe('close', () => setVisible(false))

  useEffect(() => {
    if (!visible) return

    const keyHandler = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        if (!isEnvBrowser()) emit('hideFrame')
        else setVisible(!visible)
      }
    }

    window.addEventListener('keydown', keyHandler)
    return () => window.removeEventListener('keydown', keyHandler)
  }, [visible])

  return (
    <VisibilityContext.Provider value={{}}>
      {visible && children}
    </VisibilityContext.Provider>
  )
}

export const useVisibility = () =>
  useContext<VisibilityProviderValue>(
    VisibilityContext as Context<VisibilityProviderValue>,
  )
