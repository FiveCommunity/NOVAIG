import { create } from 'zustand'

export interface VehicleProps {
  type: 'special' | 'normal' | 'favorite' | 'service';
  service: boolean;
  key: string;
  name: string;
  image_url: string;
  plate: string;
  category: string;
  max_speed: number;
  braking: number;
  agility: number;
  grip: number;

  ipva: boolean;
  arrested: boolean;
}

export interface GarageProps {
  vehicles: VehicleProps[];

  update: (props: Partial<Omit<GarageProps, 'update'>>) => void;
}

export const useGarage = create<GarageProps>((set) => ({
  vehicles: [],

  update: (props) => set(props)
}))