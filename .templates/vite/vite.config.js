import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

const { DEV_PORT = '3001' } = process.env

const SOURCE = new URL('./src/', import.meta.url).pathname
const DESTINATION = new URL('./public/', import.meta.url).pathname

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  root: SOURCE,
  build: {
    outDir: DESTINATION,
    emptyOutDir: true
  },
  server: {
    port: Number.parseInt(DEV_PORT, 10)
  }
})
