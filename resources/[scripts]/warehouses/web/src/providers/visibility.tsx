import { createContext, useEffect, useState } from 'react'

import { useNuiEvent } from '../hooks/useNuiEvent'
import { isEnvBrowser } from '../utils/misc'
import fetch from '../utils/fetch'
import { useConfig } from '../hooks/useConfig'
import { debugData } from '../utils/debugData'
import { useNavigate } from 'react-router-dom'

const VisibilityContext = createContext<boolean | null>(null)

export const VisibilityProvider: React.FC<{ children: JSX.Element }> = ({ children }) => {
  const [visible, setVisible] = useState(isEnvBrowser())
  const navigate = useNavigate()

  useEffect(() => {
    if (!visible) return

    const onKeyDown = (event: KeyboardEvent) => {
      if (event.code === 'Escape') {
        setVisible(false)
        if (!isEnvBrowser()) return fetch('CLOSE')
      }
    }

    window.addEventListener('keydown', onKeyDown)
    return () => window.removeEventListener('keydown', onKeyDown)
  }, [visible])

  useNuiEvent('open', () => {
    setVisible(true)
    navigate('/')
  })
  useNuiEvent('close', () => setVisible(false))

  return (
    <VisibilityContext.Provider value={visible}>
      { visible && children }
    </VisibilityContext.Provider>
  )
}
