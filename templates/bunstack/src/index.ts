import indexHTML from './client/index.html'

const server = Bun.serve({
  port: Number.parseInt(Bun.env.PORT ?? '3000', 10),
  routes: {
    '/*': indexHTML,
  },
})

console.log(`Server listening at ${server.url}`)
