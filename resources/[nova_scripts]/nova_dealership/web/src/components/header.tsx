import clsx from "clsx";
import { motion } from "framer-motion";
import { useNavigate } from "react-router-dom";
import logo from "../assets/logo.svg";

export default function Header({
  category,
  setCategory,
}: {
  category: string;
  setCategory: (category: string) => void;
}) {
  const navigate = useNavigate();

  const handleCategoryChange = (newCategory: string) => {
    setCategory(newCategory);
    navigate("/dealer");
  };

  return (
    <header className="w-full h-[1.1875rem] flex gap-[2.12rem]">
      <motion.p
        onClick={() => handleCategoryChange("esportivos")}
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3 }}
        className={clsx("cursor-pointer pb-2 border-[#1E90F3] w-fit text-white/50 text-[0.9375rem]", {
          "border-b !text-white": category === "esportivos",
        })}
      >
        ESPORTIVOS
      </motion.p>
      <motion.p
        onClick={() => handleCategoryChange("sedan")}
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.1 }}
        className={clsx("hover:border-b cursor-pointer border-[#1E90F3] w-fit text-white/50 pb-2 text-[0.9375rem]", {
          "border-b !text-white": category === "sedan",
        })}
      >
        SEDAN
      </motion.p>
      <motion.p
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.2 }}
        onClick={() => handleCategoryChange("motos")}
        className={clsx("hover:border-b cursor-pointer border-[#1E90F3] w-fit text-white/50 pb-2 text-[0.9375rem]", {
          "border-b !text-white": category === "motos",
        })}
      >
        MOTOS
      </motion.p>
      <motion.p
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.3 }}
        onClick={() => handleCategoryChange("vips")}
        className={clsx(
          "hover:border-b cursor-pointer border-[#1E90F3]  text-white w-[3.3125rem] h-[1.3125rem] accent flex items-center justify-center text-[0.9375rem]",
          {
            "border-b !text-white": category === "vips",
          }
        )}
      >
        VIPS
      </motion.p>
      <motion.div
        initial={{ opacity: 0, scale: 0.8 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.5 }}
        className="mx-[13.875rem] flex items-center justify-center"
      >
        <img onClick={() => navigate("/")} className="h-[3.0625rem] cursor-pointer" src={logo} alt="" />
      </motion.div>
      <motion.p
        onClick={() => handleCategoryChange("off-roads")}
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.4 }}
        className={clsx("hover:border-b cursor-pointer border-[#1E90F3] w-fit text-white/50 pb-2 text-[0.9375rem]", {
          "border-b !text-white": category === "off-roads",
        })}
      >
        OFF-ROADS
      </motion.p>
      <motion.p
        onClick={() => handleCategoryChange("caminhoes")}
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.5 }}
        className={clsx("hover:border-b cursor-pointer border-[#1E90F3] w-fit text-white/50 pb-2 text-[0.9375rem]", {
          "border-b !text-white": category === "caminhoes",
        })}
      >
        CAMINHÕES
      </motion.p>
      <motion.p
        onClick={() => handleCategoryChange("aeronaves")}
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.6 }}
        className={clsx("hover:border-b cursor-pointer border-[#1E90F3] w-fit text-white/50 pb-2 text-[0.9375rem]", {
          "border-b !text-white": category === "aeronaves",
        })}
      >
        AERONAVES
      </motion.p>
      <motion.p
        onClick={() => handleCategoryChange("outros")}
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.7 }}
        className={clsx("hover:border-b cursor-pointer border-[#1E90F3] w-fit text-white/50 pb-2 text-[0.9375rem]", {
          "border-b !text-white": category === "outros",
        })}
      >
        OUTROS
      </motion.p>
      <motion.p
        onClick={() => handleCategoryChange("meus-veiculos")}
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, delay: 0.7 }}
        className={clsx("hover:border-b cursor-pointer border-[#1E90F3] w-fit text-white/50 pb-2 text-[0.9375rem]", {
          "border-b !text-white": category === "meus-veiculos",
        })}
      >
        MEUS VEÍCULOS
      </motion.p>
    </header>
  );
}
