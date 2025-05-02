import { Archive, Clock, Menu, Search, Settings, Tally5 } from 'lucide-react'
import { useLocation, useNavigate } from 'react-router-dom'
import clsx from 'clsx'
import { useNui } from '@/store/useNui'

export default function Aside() {
  const { pathname } = useLocation()
  const { user, org } = useNui()
  const navigate = useNavigate()

  return (
    <div className="w-[17.5rem] flex flex-col items-center py-12 h-[35.625rem] muted-foreground">
      <img className="max-h-[4.625rem] h-[4.625rem]" src={org.icon} alt="" />
      <div className="foreground py-2 px-5 flex items-center gap-2 mt-1.5">
        <div
          className="w-[0.5rem] h-[0.5rem] rounded-full bg-green-400"
          style={{
            filter: 'drop-shadow(0px 0px 9.7px rgba(83, 255, 121, 0.25))',
          }}
        />
        <p className="text-xs text-white font-bold">{org.name}</p>
      </div>
      <div className="flex items-center flex-col gap-1.5 mt-4">
        <div
          onClick={() => navigate('/home')}
          className="flex items-center gap-1.5 cursor-pointer"
        >
          <div
            className={clsx(
              'w-[2rem] h-[2rem] rounded foreground grid place-items-center',
              {
                '!bg-[#0066FF]': pathname === '/home',
              },
            )}
          >
            <Menu
              className={clsx('w-4 text-white/50', {
                '!text-white': pathname === '/home',
              })}
            />
          </div>
          <div
            className={clsx(
              'w-[13.125rem] h-8 rounded foreground text-white/50 flex items-center px-3',
              {
                '!bg-[#0066FF]': pathname === '/home',
              },
            )}
          >
            <p
              className={clsx('text-white/50 text-xs font-bold', {
                '!text-white': pathname === '/home',
              })}
            >
              DASHBOARD
            </p>
          </div>
        </div>
        <div
          onClick={() => navigate('/search')}
          className="flex items-center gap-1.5 cursor-pointer"
        >
          <div
            className={clsx(
              'w-[2rem] h-[2rem] rounded foreground grid place-items-center',
              {
                '!bg-[#0066FF]': pathname === '/search',
              },
            )}
          >
            <Search
              className={clsx('w-4 text-white/50', {
                '!text-white': pathname === '/search',
              })}
            />
          </div>
          <div
            className={clsx(
              'w-[13.125rem] h-8 rounded foreground text-white/50 flex items-center px-3',
              {
                '!bg-[#0066FF]': pathname === '/search',
              },
            )}
          >
            <p
              className={clsx('text-white/50 text-xs font-bold', {
                '!text-white': pathname === '/search',
              })}
            >
              CONSULTA
            </p>
          </div>
        </div>
        <div
          onClick={() => navigate('/reportcard')}
          className="flex items-center gap-1.5 cursor-pointer"
        >
          <div
            className={clsx(
              'w-[2rem] h-[2rem] rounded foreground grid place-items-center',
              {
                '!bg-[#0066FF]': pathname === '/reportcard',
              },
            )}
          >
            <Archive
              className={clsx('w-4 text-white/50', {
                '!text-white': pathname === '/reportcard',
              })}
            />
          </div>
          <div
            className={clsx(
              'w-[13.125rem] h-8 rounded foreground text-white/50 flex items-center px-3',
              {
                '!bg-[#0066FF]': pathname === '/reportcard',
              },
            )}
          >
            <p
              className={clsx('text-white/50 text-xs font-bold', {
                '!text-white': pathname === '/reportcard',
              })}
            >
              BOLETIM DE OCORRÊNCIA
            </p>
          </div>
        </div>
        <div
          onClick={() => navigate('/searcharrest')}
          className="flex items-center gap-1.5 cursor-pointer"
        >
          <div
            className={clsx(
              'w-[2rem] h-[2rem] rounded foreground grid place-items-center',
              {
                '!bg-[#0066FF]': pathname === '/searcharrest',
              },
            )}
          >
            <Tally5
              className={clsx('w-4 text-white/50', {
                '!text-white': pathname === '/searcharrest',
              })}
            />
          </div>
          <div
            className={clsx(
              'w-[13.125rem] h-8 rounded foreground text-white/50 flex items-center px-3',
              {
                '!bg-[#0066FF]': pathname === '/searcharrest',
              },
            )}
          >
            <p
              className={clsx('text-white/50 text-xs font-bold', {
                '!text-white': pathname === '/searcharrest',
              })}
            >
              EFETUAR PRISÃO
            </p>
          </div>
        </div>
        <div
          onClick={() => navigate('/history')}
          className="flex items-center gap-1.5 cursor-pointer"
        >
          <div
            className={clsx(
              'w-[2rem] h-[2rem] rounded foreground grid place-items-center',
              {
                '!bg-[#0066FF]': pathname === '/history',
              },
            )}
          >
            <Clock
              className={clsx('w-4 text-white/50', {
                '!text-white': pathname === '/history',
              })}
            />
          </div>
          <div
            className={clsx(
              'w-[13.125rem] h-8 rounded foreground text-white/50 flex items-center px-3',
              {
                '!bg-[#0066FF]': pathname === '/history',
              },
            )}
          >
            <p
              className={clsx('text-white/50 text-xs font-bold', {
                '!text-white': pathname === '/history',
              })}
            >
              HISTÓRICO
            </p>
          </div>
        </div>
        <div
          onClick={() => navigate('/config')}
          className="flex items-center gap-1.5 cursor-pointer"
        >
          <div
            className={clsx(
              'w-[2rem] h-[2rem] rounded foreground grid place-items-center',
              {
                '!bg-[#0066FF]': pathname === '/config',
              },
            )}
          >
            <Settings
              className={clsx('w-4 text-white/50', {
                '!text-white': pathname === '/config',
              })}
            />
          </div>
          <div
            className={clsx(
              'w-[13.125rem] h-8 rounded foreground text-white/50 flex items-center px-3',
              {
                '!bg-[#0066FF]': pathname === '/config',
              },
            )}
          >
            <p
              className={clsx('text-white/50 text-xs font-bold', {
                '!text-white': pathname === '/config',
              })}
            >
              CONFIGURAÇÃO
            </p>
          </div>
        </div>
      </div>
      <div className="flex items-center gap-3 self-start ml-4 mt-14">
        <img
          src={user.image}
          className="w-[2.875rem] h-[2.875rem] rounded-full bg-blue-500"
          alt=""
        />
        <div>
          <p className="text-sm text-white font-bold">{user.name}</p>
          <p className="text-xs text-white/60">{user.role}</p>
        </div>
      </div>
      <div className="w-[15.5rem] h-[2rem] px-2 py-2 flex items-center foreground mt-3">
        <Clock className="w-4 text-white/50" />
        <p className="w-[9.625rem] pr-1.5 text-[0.625rem] text-[#54545D] ml-2 font-bold">
          TEMPO DE ATIVIDADE
        </p>
        <p className="text-[0.75rem] text-white font-bold">
          {user.activityTime}
        </p>
      </div>
    </div>
  )
}
