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
import { test } from '@/utils/test'
import { useNavigate } from 'react-router-dom'

interface VisibilityProviderValue {}

const VisibilityContext = createContext<VisibilityProviderValue | null>(null)

test([
  {
    action: 'open',
    data: {},
  },
])

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [visible, setVisible] = useState(isEnvBrowser())
  const navigate = useNavigate()

  observe('open', (data) => {
    setVisible(true)
    if (data === 'STORE') navigate('/store')
    if (data === 'EDIT_BENCH') navigate('/home')
  })

  observe('close', () => setVisible(false))

  useEffect(() => {
    if (!visible) return
    if(isEnvBrowser()) navigate('/home')
    const keyHandler = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        if (!isEnvBrowser()) emit('CLOSE')
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
