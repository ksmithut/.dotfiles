import React from 'react'
import { Switch, Route, Redirect } from 'react-router-dom'
import Greeting from '../../components/Greeting'

const Main = () => (
  <Switch>
    <Route exact path='/' component={Greeting} />
    <Redirect to='/' />
  </Switch>
)

export default Main
