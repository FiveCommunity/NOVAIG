import clsx from "clsx";
import { isEnvBrowser } from "../utils/misc";

interface ContainerProps {
  children: React.ReactNode;
}

export function Container({ children }: ContainerProps) {
  return (
    <div
      className={clsx(
        "w-screen h-screen p-5 overflow-hidden relative select-none",
        isEnvBrowser() && "bg-gray-500"
      )}
    >
      {children}
    </div>
  );
}
