import 'normalize.css'
import React from 'react'
import ReactDOM from 'react-dom'
import App from './App'

const LOCALE = process.env.REACT_APP_LOCALE
const messages = require(`./messages/${LOCALE}.json`)
const rootElement = document.getElementById('root')
const app = <App locale={LOCALE} messages={messages} />

ReactDOM.render(app, rootElement)
