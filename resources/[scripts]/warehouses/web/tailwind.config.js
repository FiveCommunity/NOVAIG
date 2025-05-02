/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{html,tsx}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: '"Baloo 2"',
      },
      colors: {
        primary: {
          500: '#93D441',
          600: '#6AA71E'
        },
        neutral: {
          500: '#101010',
          600: '#121212'
        },
      }
    },
  },
  plugins: [
    require('tailwindcss-animated')
  ],
}

