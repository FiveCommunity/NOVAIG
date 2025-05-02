import { create } from 'zustand'

interface NuiState {}

export const useNui = create<NuiState>((set) => ({}))
