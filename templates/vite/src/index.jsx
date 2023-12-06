import React from 'react'
import { createRoot } from 'react-dom/client'

const root = document.getElementById('root')
if (root) {
  const app = <h1 className="text-3xl font-bold">Hello World</h1>
  createRoot(root).render(app)
}
