import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'
import { TanStackRouterVite } from '@tanstack/router-plugin/vite'
import { fileURLToPath, URL } from 'node:url'
import { existsSync } from 'node:fs'

const routesDir = fileURLToPath(new URL('./src/routes', import.meta.url))
const hasRoutes = existsSync(routesDir)

export default defineConfig({
  root: '.',
  publicDir: 'public',
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  plugins: [
    ...(hasRoutes ? [TanStackRouterVite({ target: 'react', autoCodeSplitting: true, routesDirectory: routesDir })] : []),
    react(),
    tailwindcss(),
  ],
  build: {
    outDir: 'dist',
    emptyOutDir: true,
  },
})
