/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{html,tsx}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Montserrat']
      },
      colors: {
        primary: '#FE3800'
      },
      background: {
      },
      backgroundImage: {
        'back': 'url("/images/background.webp")',
        'primary-gradient': 'linear-gradient(135deg, #FE3800 0%, #FF3800 100%)'
      },
      boxShadow: {
        'primary': '0 0 .875rem 0 #FE3800'
      }
    },
  },
  plugins: [
    require('tailwindcss-animated')
  ],
}

