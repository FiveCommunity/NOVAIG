import { create } from 'zustand'

export interface ConfigProps {
  update: (props: Partial<Omit<ConfigProps, 'update'>>) => void;
}

export const useConfig = create<ConfigProps>((set) => ({
  update: (props: Partial<Omit<ConfigProps, 'update'>>) => set(props)
}))