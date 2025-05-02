import InsidentReportModal from '@/components/insident-report'
import ReportModal from '@/components/report-modal'
import { emit } from '@/utils/emit'
import dayjs from 'dayjs'
import { useEffect, useState } from 'react'

interface IReportProps {
  id: number
  officer: string
  date: number
  involved: string
  description: string
}

export default function ReportCard() {
  const [reports, setReports] = useState<IReportProps[]>([])
  const [createReport, setCreateReport] = useState<boolean>(false)
  const [detailReport, setDetailReport] = useState<number>(-1)

  useEffect(() => {
    emit<IReportProps[]>('getReports', {}, [
      {
        id: 1,
        involved: 'Maka da Silva',
        officer: 'João',
        date: 1720920864,
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      },
    ]).then(setReports)
  }, [])

  function handleDeleteInsident(id: number) {
    setReports((prevState) => prevState.filter((report) => report.id !== id))
    emit('DELETE_INSIDENT', id)
  }

  function RefreshReports() {
    emit<IReportProps[]>('getReports', {}, [
      {
        id: 1,
        involved: 'Maka da Silva',
        officer: 'João',
        date: 1720920864,
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      },
    ]).then(setReports)
  }

  return (
    <div className="w-[55.875rem] h-[35.625rem] background p-4">
      <div className="flex items-center gap-2.5">
        <div className="w-[42.75rem] h-[1.5rem] rounded bg-white bg-opacity-[3%] flex items-center px-5">
          <p className="text-[#54545D] text-[.625rem] font-bold w-[4.0625rem]">
            #
          </p>
          <p className="text-[#54545D] text-[.625rem] font-bold w-[11.5rem]">
            ENVOLVIDO
          </p>
          <p className="text-[#54545D] text-[.625rem] font-bold w-[15.0625rem]">
            OFICIAL RESPONSÁVEL
          </p>
          <p className="text-[#54545D] text-[.625rem] font-bold">DATA</p>
        </div>
        <div
          onClick={() => setCreateReport(true)}
          className="w-[10.5rem] h-[1.5rem] rounded cursor-pointer bg-white bg-opacity-[3%] grid place-items-center"
        >
          <p className="text-[0.625rem] text-white">CRIAR BOLETIM</p>
        </div>
      </div>
      <div className="mt-[.63rem] flex flex-col gap-2">
        {reports.map((report, i) => {
          return (
            <div
              className="w-[53.875rem] h-[2.375rem] rounded bg-white bg-opacity-[2%] flex items-center px-5"
              key={i}
            >
              <p className="text-white font-bold text-xs w-[4.0625rem]">
                {report.id}
              </p>
              <p className="text-white font-bold text-xs w-[11.5rem]">
                {report.involved}
              </p>
              <p className="text-white font-bold text-xs w-[15.0625rem]">
                {report.officer}
              </p>
              <p className="text-white font-bold text-xs w-[14.75rem]">
                {dayjs(report.date * 1000).format('DD/MM/YYYY')}
              </p>
              <div className="flex items-center gap-2">
                <svg
                  onClick={() => setDetailReport(i)}
                  className="cursor-pointer"
                  width="42"
                  height="22"
                  viewBox="0 0 42 22"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0 2C0 0.89543 0.895431 0 2 0H40C41.1046 0 42 0.895431 42 2V20C42 21.1046 41.1046 22 40 22H2C0.89543 22 0 21.1046 0 20V2Z"
                    fill="white"
                    fillOpacity="0.03"
                  />
                  <path
                    d="M14 11C14.6082 8.15556 17.5108 6 20.9997 6C24.4885 6 27.3911 8.15556 28 11C27.3918 13.8444 24.4885 16 20.9997 16C17.5108 16 14.6082 13.8444 14 11ZM20.9997 13.7778C21.8577 13.7778 22.6806 13.4851 23.2873 12.9642C23.894 12.4433 24.2349 11.7367 24.2349 11C24.2349 10.2633 23.894 9.55675 23.2873 9.03581C22.6806 8.51488 21.8577 8.22222 20.9997 8.22222C20.1416 8.22222 19.3188 8.51488 18.712 9.03581C18.1053 9.55675 17.7645 10.2633 17.7645 11C17.7645 11.7367 18.1053 12.4433 18.712 12.9642C19.3188 13.4851 20.1416 13.7778 20.9997 13.7778ZM20.9997 12.6667C20.4849 12.6667 19.9911 12.4911 19.6271 12.1785C19.2631 11.866 19.0586 11.442 19.0586 11C19.0586 10.558 19.2631 10.134 19.6271 9.82149C19.9911 9.50893 20.4849 9.33333 20.9997 9.33333C21.5145 9.33333 22.0082 9.50893 22.3723 9.82149C22.7363 10.134 22.9408 10.558 22.9408 11C22.9408 11.442 22.7363 11.866 22.3723 12.1785C22.0082 12.4911 21.5145 12.6667 20.9997 12.6667Z"
                    fill="white"
                    fillOpacity="0.45"
                  />
                </svg>
                <svg
                  onClick={() => handleDeleteInsident(report.id)}
                  className="cursor-pointer"
                  width="42"
                  height="22"
                  viewBox="0 0 42 22"
                  fill="none"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M0 2C0 0.89543 0.895431 0 2 0H40C41.1046 0 42 0.895431 42 2V20C42 21.1046 41.1046 22 40 22H2C0.89543 22 0 21.1046 0 20V2Z"
                    fill="white"
                    fillOpacity="0.03"
                  />
                  <path
                    d="M22.3332 10.3333V14.3333M19.6665 10.3333V14.3333M16.9998 7.66667V15.6667C16.9998 16.0203 17.1403 16.3594 17.3904 16.6095C17.6404 16.8595 17.9795 17 18.3332 17H23.6665C24.0201 17 24.3593 16.8595 24.6093 16.6095C24.8594 16.3594 24.9998 16.0203 24.9998 15.6667V7.66667M15.6665 7.66667H26.3332M17.6665 7.66667L18.9998 5H22.9998L24.3332 7.66667"
                    stroke="white"
                    strokeOpacity="0.45"
                    strokeWidth="1.2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                </svg>
              </div>
            </div>
          )
        })}
      </div>
      {createReport && (
        <ReportModal
          RefreshReports={RefreshReports}
          setShowModal={setCreateReport}
        />
      )}
      {detailReport !== -1 && (
        <InsidentReportModal
          close={() => setDetailReport(-1)}
          id={reports[detailReport].id}
          date={reports[detailReport].date}
          description={reports[detailReport].description}
          involved={reports[detailReport].involved}
          officer={reports[detailReport].officer}
        />
      )}
    </div>
  )
}
