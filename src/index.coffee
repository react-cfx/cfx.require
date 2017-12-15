import dd from 'ddeyes'
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

      r.code = await compiler baseCode, id

      r

    , {
      code: ''
    }

    requireFromString code

  register: ->

    return unless require.extensions

    plugins.map ({
      name
      exts
      compiler
    }) ->
      exts.map (ext) ->
        require.extensions[ext] = (module, filename) ->
          answer = await compiler(
            getFileCode getFilePath filename, exts
            filename
          )
          module._compile answer, filename

    Module = require 'module'

    # findExtension = (filename) ->
    #   extensions = path
    #   .basename filename
    #   .split '.'
    #   extensions.shift() if extensions[0] is ''
    #   while extensions.shift()
    #     curExtension = '.' + extensions.join '.'
    #     return curExtension if Module._extensions[curExtension]
    #   '.js'

    Module::load = (filePath) ->

      { id } = plugins.reduce (r, {
        name
        exts
        compiler
      }) ->

        return unless r.id is ''

        r.id = getFilePath filePath, exts

        r

      , {
        id: ''
      }

      # dd filePath unless id?

      return unless id?

      @filename = id
      @paths = Module._nodeModulePaths path.dirname id

      extension = path.extname id
      Module._extensions[extension] @, id

      @loaded = true
