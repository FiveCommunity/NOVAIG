import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './app'
import './styles/global.css'
import { VisibilityProvider } from './providers/Visibility'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <VisibilityProvider>
      <App />
    </VisibilityProvider>
  </React.StrictMode>,
)
