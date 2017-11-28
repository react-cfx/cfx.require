# import dd from 'ddeyes'
import path from 'path'
import {
  getFilePath
  getFileCode
} from './require'
import requireFromString from 'require-from-string'

export default (plugins) ->

  ### plugins like

  # coffee
    export default (ops) ->

      name: '$pluginName'
      exts: [
        '.coffee'
      ]
      compiler: (code, id) ->

  # reason

  [
    coffee()
    reason()
  ]

  ###

  gdf: (obj) -> obj.default

  require: (
    requirePath 
    parentPath = module.parent.filename
  ) ->

    requireFile = path.join(
      path.dirname parentPath
      requirePath
    )

    { code } = plugins.reduce (r, {
      name
      exts
      compiler
    }) ->

      return unless r.code is ''

      id = getFilePath requireFile, exts

      baseCode = getFileCode id

      r.code = compiler baseCode, id

      r

    , {
      code: ''
    }

    requireFromString code
