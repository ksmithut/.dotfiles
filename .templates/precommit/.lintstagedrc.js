export default {
  '**/*': 'prettier-standard --lint',
  '**/*.{js,json}': () => 'tsc'
}
