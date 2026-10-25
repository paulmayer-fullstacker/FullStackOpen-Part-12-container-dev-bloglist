// vite.config.js:
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    allowedHosts: ['frontend'], // Allow us to access the frontend service from the browser (http://localhost:8080).
    proxy: {
      '/api': {
        target: 'http://localhost:3002',
        changeOrigin: true
      }
    }
  },
  test: {
    environment: 'jsdom', // Instruct Vitest to use JSDOM instead of the default Node environment.
    globals: true,
    setupFiles: './testSetup.js'
  }
})
