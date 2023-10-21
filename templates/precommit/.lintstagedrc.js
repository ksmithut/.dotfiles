export default {
  '**/*': 'prettier --write',
  '**/*.js': 'eslint',
  '**/*.{js,json}': () => 'tsc'
}
