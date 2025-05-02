
import React from 'react'
import ReactDOM from 'react-dom/client'

import './styles/styles.css'
import { App } from './app'
import { VisibilityProvider } from './providers/visibility'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <VisibilityProvider>
    <App />
  </VisibilityProvider>
)
