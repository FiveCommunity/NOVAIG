import { create } from 'zustand'

export interface IData {
  safezone: boolean
  assaultTime: boolean
  clock: string;
  volume: 1 | 2 | 3 | 4;
  id: number;
  frequency: number;
  talking: boolean;
  health: number;
  armour: number;
  energy: number;
  vehicle: {
    data: boolean;
    speed: number;
    rpm: number;
    engine: number;
    nitro: number;
    march: number;
    light: boolean;
    seatbelt: boolean;
    lock: boolean;
    fuel: number;
  },
  weapon: {
    show: boolean;
    image: string
    current: number
    max: number
  };
  street: string
}

export interface CacheProps {
  data: IData
  updateData: (props: IData) => void;
}

export const useData = create<CacheProps>((set) => ({
  data: {} as IData,
  updateData: (data: IData) => set({ data })
}))