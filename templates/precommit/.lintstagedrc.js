export default {
  '**/*': 'prettier --write',
  '**/*.{js,json}': () => 'tsc',
}
