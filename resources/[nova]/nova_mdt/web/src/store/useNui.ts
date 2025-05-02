import { create } from 'zustand'

export interface ICrimes {
  name: string
  fine: number
  bail: number
  mounths: number
}

export interface IMitigatingFactors {
  name: string
  fine: number
  mounths: number
}

interface IOrg {
  name: string
  icon: string
}

interface IUserArrest {
  name: string
  bail: boolean
  accused: string
  id: number
  mounths: number
  totalFine: number
  totalBail: number
  image: string
  crimes: ICrimes[]
  mitigatingFactors: IMitigatingFactors[]
}

interface IUser {
  name: string
  role: string
  image: string
  activityTime: string
}

interface NuiState {
  crimes: ICrimes[]
  setCrimes: (crimes: ICrimes[]) => void
  mitigatingFactors: IMitigatingFactors[]
  setMitigatingFactors: (mitigatingFactors: IMitigatingFactors[]) => void
  userArrest: IUserArrest
  setUserArrest: (userArrest: IUserArrest) => void
  user: IUser
  setUser: (user: IUser) => void
  org: IOrg
  setOrg: (org: IOrg) => void
}

export const useNui = create<NuiState>((set) => ({
  setCrimes: (crimes) => set({ crimes }),
  setMitigatingFactors: (mitigatingFactors) => set({ mitigatingFactors }),
  crimes: [
    {
      name: 'Assalto a mão armada',
      fine: 1000,
      bail: 500,
      mounths: 1,
    },
    {
      name: 'Assalto a banco',
      fine: 5000,
      bail: 1000,
      mounths: 2,
    },
    {
      name: 'Assassinato',
      fine: 10000,
      bail: 2000,
      mounths: 3,
    },
    {
      name: 'Assalto a mão armada',
      fine: 1000,
      bail: 500,
      mounths: 1,
    },
    {
      name: 'Assalto a banco',
      fine: 5000,
      bail: 1000,
      mounths: 2,
    },
    {
      name: 'Assassinato',
      fine: 10000,
      bail: 2000,
      mounths: 3,
    },
    {
      name: 'Assalto a mão armada',
      fine: 1000,
      bail: 500,
      mounths: 1,
    },
    {
      name: 'Assalto a banco',
      fine: 5000,
      bail: 1000,
      mounths: 2,
    },
    {
      name: 'Assassinato',
      fine: 10000,
      bail: 2000,
      mounths: 3,
    },
  ],
  mitigatingFactors: [
    {
      name: 'Confissão',
      fine: 0,
      mounths: 0.5,
    },
    {
      name: 'Colaboração',
      fine: 0,
      mounths: 0.3,
    },
    {
      name: 'Arrependimento',
      fine: 0,
      mounths: 0.2,
    },
    {
      name: 'Confissão',
      fine: 0,
      mounths: 0.5,
    },
    {
      name: 'Colaboração',
      fine: 0,
      mounths: 0.3,
    },
    {
      name: 'Arrependimento',
      fine: 0,
      mounths: 0.2,
    },
    {
      name: 'Confissão',
      fine: 0,
      mounths: 0.5,
    },
    {
      name: 'Colaboração',
      fine: 0,
      mounths: 0.3,
    },
    {
      name: 'Arrependimento',
      fine: 0,
      mounths: 0.2,
    },
  ],
  setUserArrest: (userArrest) => set({ userArrest }),
  userArrest: {
    name: '',
    id: 0,
    bail: false,
    image: '',
    accused: '',
    mounths: 0,
    totalFine: 0,
    totalBail: 0,
    crimes: [],
    mitigatingFactors: [],
  },
  setUser: (user) => set({ user }),
  user: {
    name: 'Maka da Silva',
    role: 'Chefe de Policia',
    image: 'https://i.imgur.com/4BcQ1vB.jpg',
    activityTime: '05:38:43',
  },
  setOrg: (org) => set({ org }),
  org: {
    name: 'Policia Civil',
    icon: 'https://i.imgur.com/4BcQ1vB.jpg',
  },
}))
