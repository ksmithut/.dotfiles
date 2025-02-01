import type { Route } from './+types/_index'

export function meta({}: Route.MetaArgs) {
  return [
    { title: 'Page Title' },
    { name: 'description', content: 'Some Description' },
  ]
}

export async function loader(args: Route.LoaderArgs) {
  return {}
}

export default function HomePage({ loaderData }: Route.ComponentProps) {
  return <h1 className="text-2xl">Hello World</h1>
}
