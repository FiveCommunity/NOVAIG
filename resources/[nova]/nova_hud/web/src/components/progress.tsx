import { useEffect, useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";

interface ProgressProps {
  seconds: number;
}

debugData([
  {
    action: "Progress",
    data: {
      seconds: 10,
    },
  },
]);

export function Progress() {
  const progressRef = useRef<SVGSVGElement | null>(null);
  const [progress, setProgress] = useState<ProgressProps | null>(null);
  const [percentage, setPercentage] = useState(100);

  useNuiEvent<ProgressProps>("Progress", (data) => {
    setProgress(data);
  });

  useEffect(() => {
    if (progress === null) return;

    if (progress) {
      const totalSeconds = progress.seconds;
      const startTime = Date.now();

      const interval = setInterval(() => {
        const elapsed = (Date.now() - startTime) / 1000;
        const remaining = totalSeconds - elapsed;
        const currentPercentage = Math.max((remaining / totalSeconds) * 100, 0);
        setPercentage(100 - currentPercentage);

        if (remaining <= 0) {
          clearInterval(interval);
          setProgress(null);
        }
      }, 100);

      return () => clearInterval(interval);
    }
  }, [progress]);

  useEffect(() => {
    if (progressRef.current) {
      const path = progressRef.current.querySelector("path:nth-of-type(2)");
      if (path) {
        const svgPath = path as SVGPathElement;
        const totalLength = svgPath.getTotalLength();
        svgPath.style.strokeDasharray = `${totalLength}`;
        svgPath.style.strokeDashoffset = `${
          totalLength - totalLength * (percentage / 100)
        }`;
      }
    }
  }, [percentage]);

  return (
    progress && (
      <div
        key={String(Math.floor(percentage) !== 100)}
        className="absolute left-1/2 -translate-x-1/2 bottom-52 flex items-center gap-[.63rem] animate-fade-in"
      >
        <div className="w-[2.5rem] h-[2.875rem] bg-progress bg-cover bg-center bg-no-repeat flex items-center justify-center">
          <svg
            ref={progressRef}
            className="w-[2.125rem]"
            viewBox="0 0 36 40"
            fill="none"
          >
            <path
              d="M15.677 38.5229L3.48918 31.4454C1.94828 30.5507 1.00002 28.9034 1.00002 27.1216V19.1011V12.7911C1.00002 11.0013 1.95669 9.348 3.50843 8.45611L15.6965 1.45085C17.2568 0.554094 19.1785 0.564946 20.7285 1.47927L32.5404 8.44696C34.0646 9.34607 35 10.9839 35 12.7535V19.1011V27.1593C35 28.9209 34.073 30.5525 32.5598 31.4543L20.7476 38.4941C19.188 39.4236 17.2471 39.4346 15.677 38.5229Z"
              stroke="white"
              strokeOpacity="0.12"
              strokeWidth="1.4"
            />
            <path
              d="M15.677 38.5229L3.48918 31.4454C1.94828 30.5507 1.00002 28.9034 1.00002 27.1216V19.1011V12.7911C1.00002 11.0013 1.95669 9.348 3.50843 8.45611L15.6965 1.45085C17.2568 0.554094 19.1785 0.564946 20.7285 1.47927L32.5404 8.44696C34.0646 9.34607 35 10.9839 35 12.7535V19.1011V27.1593C35 28.9209 34.073 30.5525 32.5598 31.4543L20.7476 38.4941C19.188 39.4236 17.2471 39.4346 15.677 38.5229Z"
              stroke="#E51717"
              strokeWidth="1.4"
              strokeDashoffset={0}
              strokeDasharray={0}
            />
          </svg>
        </div>
        <div>
          <p className="text-white/90 text-[0.8125rem] font-bold">
            {Math.floor(percentage)}%
          </p>
          <p className="text-white/55 text-[0.6875rem] font-normal leading-[114.03%]">
            Aguarde...
          </p>
        </div>
      </div>
    )
  );
}
