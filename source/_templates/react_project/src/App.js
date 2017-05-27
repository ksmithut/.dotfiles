import React from 'react'
import PropTypes from 'prop-types'
import { IntlProvider } from 'react-intl'
import { HashRouter as Router } from 'react-router-dom'
import Main from './pages/Main'

const App = props => (
  <IntlProvider locale={props.locale} messages={props.messages}>
    <Router>
      <Main />
    </Router>
  </IntlProvider>
)

App.propTypes = {
  locale: PropTypes.string.isRequired,
  messages: PropTypes.objectOf(PropTypes.string.isRequired).isRequired
}

export default App
