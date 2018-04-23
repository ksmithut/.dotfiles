#!/usr/bin/env node
'use strict'

const readline = require('readline')

function ask(rl, question) {
  return new Promise(resolve => rl.question(question, resolve))
}

/**
 * testing
 * linting
 *
 * client
 * server
 * cli
 * module
 */
