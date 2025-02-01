import { defineConfig } from 'drizzle-kit'

const { DATABASE_URL } = process.env
if (!DATABASE_URL) throw new ReferenceError(`DATABASE_URL is required`)

export default defineConfig({
  out: './drizzle',
  schema: './app/db/schema.ts',
  dialect: 'postgresql',
  dbCredentials: {
    url: DATABASE_URL,
  },
})
