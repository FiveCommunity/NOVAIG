import React, { createContext, useContext, useEffect, useState } from 'react'
import { isEnvBrowser } from '../utils/misc'
import { observe } from '../hooks/observe'
import { emit } from '../utils/emit'

interface VisibilityProviderValue {
  visible: boolean
  setVisible: (visible: boolean) => void
}

const VisibilityContext = createContext<VisibilityProviderValue | null>(null)

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [visible, setVisible] = useState(isEnvBrowser())

  observe('open', () => {
    setVisible(true)
  })

  observe('close', () => {
    setVisible(false)
  })

  useEffect(() => {
    if (!visible) return

    const keyHandler = (e: KeyboardEvent) => {
      if (e.code !== 'Escape') return

      setVisible(false)
      if (!isEnvBrowser()) emit('CLOSE')
    }

    window.addEventListener('keydown', keyHandler)
    return () => window.removeEventListener('keydown', keyHandler)
  }, [visible])

  return (
    <VisibilityContext.Provider value={{ visible, setVisible }}>
      {visible && children}
    </VisibilityContext.Provider>
  )
}

export const useVisibility = () => {
  const context = useContext(VisibilityContext)
  if (context === null) {
    throw new Error('useVisibility must be used within a VisibilityProvider')
  }
  return context
}
