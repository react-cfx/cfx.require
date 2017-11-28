import dd from 'ddeyes'
import 'shelljs/make'

import path from 'path'

import {
  getFilePath
  getFileCode
} from '../src/require'

target.all = ->
  dd 'Hello Wolrd!!!'

target.require = ->

  # filePath = getFileCode getFilePath (path.join __dirname, './coffee')
  # , [
  #   '.coffee'
  # ]

  # dd filePath

  # filePath = getFileCode getFilePath (path.join __dirname, './coffee/index.coffee'), [
  #   '.coffee'
  # ]

  # dd filePath

  # filePath = getFileCode getFilePath (path.join __dirname, './coffee/index'), [
  #   '.coffee'
  # ]

  # dd filePath

  # filePath = getFileCode getFilePath (path.join __dirname, './coffee/index.re'), [
  #   '.coffee'
  # ]

  # dd filePath

  filePath = getFilePath '/root/cfx.require-plugin-coffee/test/coffee'
  , [ '.coffee', '.litcoffee', '.coffee.md' ]
  # , [ '.coffee' ]

  dd filePath
