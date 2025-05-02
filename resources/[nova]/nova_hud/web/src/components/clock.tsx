import { useEffect, useState } from "react"

export function Clock() {
  const [timestamp, setTimestamp] = useState(Date.now())

  useEffect(() => {
    const interval = setInterval(() => setTimestamp(Date.now()), 1000)
    return () => clearInterval(interval)
  }, [])

  const date = new Date(timestamp)

  return (
    <p className="absolute left-2 bottom-2 text-white text-sm [text-shadow:0_0_2px_rgba(0,0,0,1)]">{String(date.getDate()).padStart(2, '0')}/{String(date.getMonth() + 1).padStart(2, '0')}/{date.getFullYear()} {String(date.getHours()).padStart(2, '0')}:{String(date.getMinutes()).padStart(2, '0')}</p>
  )
}