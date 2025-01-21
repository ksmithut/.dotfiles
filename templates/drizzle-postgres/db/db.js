import { drizzle } from 'drizzle-orm/node-postgres'
import * as schema from './schema.js'

const { DATABASE_URL } = process.env
if (!DATABASE_URL) throw new ReferenceError(`DATABASE_URL is required`)

export const db = drizzle(DATABASE_URL, { schema })
