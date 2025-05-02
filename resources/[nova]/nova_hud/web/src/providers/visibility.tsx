import { Context, createContext, useContext, useState } from "react";

import { debugData } from "../utils/debugData";
import { useNuiEvent } from "../hooks/useNuiEvent";

debugData([
  {
    action: "open",
    data: null,
  },
]);

type VisibilityContextProps = boolean;

const VisibilityContext = createContext<VisibilityContextProps | null>(null);
export const VisibilityProvider = ({
  children,
}: {
  children: React.ReactNode;
}) => {
  const [visible, setVisible] = useState(true);

  useNuiEvent("open", () => setVisible(true));
  useNuiEvent("close", () => setVisible(false));

  return (
    <VisibilityContext.Provider value={visible}>
      {visible && children}
    </VisibilityContext.Provider>
  );
};

export const useVisibility = () =>
  useContext(VisibilityContext as Context<VisibilityContextProps>);
