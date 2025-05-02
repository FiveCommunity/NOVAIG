import './index.css'

import React from 'react'
import ReactDOM from 'react-dom/client'

import { Container } from './components/container'

import { App } from './app'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <Container>
    <App />
  </Container>
)
