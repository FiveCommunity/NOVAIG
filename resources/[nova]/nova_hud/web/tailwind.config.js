/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{html,tsx}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Montserrat"'],
      },
      colors: {
        'primary': '#D3132F',
        'black': {
          500: '#0F0F0FB2'
        }
      },
      backgroundImage: {
        'health': 'url("/images/health.png")',
        'armour': 'url("/images/armour.png")',
        'hexagon': 'url("/images/hexagon.png")',
        'progress': 'url("/images/progress.png")',
        'recruitment': 'url("/icons/hexagon.svg")',
        'h-progress': "url('/images/h-progress.png')",
        'white-hexagon': 'url("/images/white-hexagon.png")',
      },
      animation: {
        'fade-in': 'fade-in 0.3s ease-out',
        'slide-in': 'slide-in 0.3s ease-out',
        'slide-out': 'slide-out 0.3s ease-in'
      },
      keyframes: {
        'fade-in': {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' }
        },
        'slide-in': {
          '0%': { transform: 'translateX(100%)' },
          '100%': { transform: 'translateX(0)' }
        },
        'slide-out': {
          '0%': { transform: 'translateX(0)' },
          '100%': { transform: 'translateX(100%)' }
        }
      }
    },
  },
  plugins: [
    require('tailwindcss-animated')
  ],
}
