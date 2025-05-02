import { Context, createContext, useContext, useEffect, useState } from 'react'

import { useNuiEvent } from '../hooks/useNuiEvent'
import { debugData } from '../utils/debugData'
import { useGarage, VehicleProps } from '../hooks/useGarage'
import fetch from '../utils/fetch'
import { isEnvBrowser } from '../utils/misc'


const VisibilityContext = createContext<boolean | null>(null)
export const VisibilityProvider = ({ children }: { children: React.ReactNode }) => {
  const [visible, setVisible] = useState(isEnvBrowser())

  const { update } = useGarage()

  useNuiEvent('open', () => setVisible(true))
  useNuiEvent('close', () => setVisible(false))

  useEffect(() => {
    if (!visible) return

    fetch<VehicleProps[]>('GET_GARAGE', null, [
      {
        type: 'normal',
        key: 'asdsd',
        name: 'aasdsa',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https:/meia.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 150,
        agility: 20,
        braking: 10,
        grip: 150,
        ipva: false,
        arrested: false,
        service: false
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'bee',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      { type: 'special', key: 'mitsubishi', name: 'Mitsubishi Lancer', category: 'Esportivos', plate: 'IOE5H5RJ', image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257', max_speed: 170, agility: 20, braking: 10, grip: 100, ipva: true, arrested: false, service: false, },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'normal',
        key: 'mitsubishis',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
      {
        type: 'special',
        key: 'mitsubishi',
        name: 'Mitsubishi Lancer',
        category: 'Esportivos',
        plate: 'IOE5H5RJ',
        image_url: 'https://media.discordapp.net/attachments/852964597103329322/1299111484940353566/image.png?ex=671c035a&is=671ab1da&hm=0ac5d3c6a60fd1da728d516b8f7e2296a152ceda52ac4aadeceed1caafa990c1&=&format=webp&quality=lossless&width=550&height=257',
        max_speed: 170,
        agility: 20,
        braking: 10,
        grip: 100,
        ipva: true,
        arrested: false,
        service: false,
      },
    ])
      .then((vehicles) => {
        update({
          vehicles: vehicles
        })
      })
  }, [visible])

  useEffect(() => {
    if (!visible) return

    const keyHandler = (e: KeyboardEvent) => {
      if (e.code !== 'Escape') return

      setVisible(false)
      if (!isEnvBrowser()) fetch('CLOSE')
    }

    window.addEventListener('keydown', keyHandler)
    return () => window.removeEventListener('keydown', keyHandler)
  }, [visible])

  return (
    <VisibilityContext.Provider value={visible}>
      { visible && children }
    </VisibilityContext.Provider>
  )
}

export const useVisibility = () => useContext(VisibilityContext as Context<boolean>)