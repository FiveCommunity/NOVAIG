import './index.css'

import 'swiper/css'

import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom'

import { VisibilityProvider } from './providers/visibility'

import { Container } from './components/container'

import { HomePage } from './pages/home'
import { PropertiesPage } from './pages/properties'
import { AvailablePropertiesPage } from './pages/available-properties'
import { DetailsPropertiesPage } from './pages/details-properties'


ReactDOM.createRoot(document.getElementById('root')!).render(
  <BrowserRouter>
    <VisibilityProvider>
      <Container>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/properties/:id" element={<DetailsPropertiesPage />} />
          <Route path="/properties" element={<PropertiesPage />} />
          <Route path="/available-properties" element={<AvailablePropertiesPage />} />
          <Route path="*" element={<Navigate to="/" />} />
        </Routes>
      </Container>
    </VisibilityProvider>
  </BrowserRouter>
)
