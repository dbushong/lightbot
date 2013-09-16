fs     = require 'fs'
eg_dir = "#{require('path').dirname(process.argv[1])}/../examples"
jsons  = fs.readdirSync(eg_dir).sort()
mapped = jsons.map (file) ->
  json = fs.readFileSync "#{eg_dir}/#{file}"
  "\"#{file.replace(/\.json$/, '')}\":#{json}"

console.log "levels={#{mapped.join ','}};"
