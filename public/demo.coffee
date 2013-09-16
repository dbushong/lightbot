level_1_3 = { "board":
  [ [ {}, {}, { "goal": true } ]
  , [ { "elev": 1 }, { "elev": 1 }, { "elev": 1 } ]
  , [ {}, {}, {} ]
  ]
, "bot": { "x": 0, "y": 2, "dir": 1 }
, "prog": { "main": [ { "action": "forward" }
                    , { "action": "forward" }
                    , { "action": "left" }
                    , { "action": "jump" }
                    , { "action": "jump" }
                    , { "action": "bulb" }
                    ]
          }
}


level_2_2 = { "board":
  [ [ { "elev": 2 }, {}, { "elev": 2 }, { "elev": 2 }, { "elev": 2 } ]
  , [ { "elev": 2 }, {}, { "elev": 2 }, {},            { "elev": 2 } ]
  , [ { "elev": 2 }, { "elev": 2 }, {"elev": 2}, {}, {"elev": 2, "goal": true} ]
  ]
, "bot": { "x": 0, "y": 0, "dir": 2 }
, "prog": { "main": [ { "action": "p1" }
                    , { "action": "left" }
                    , { "action": "p1" }
                    , { "action": "left" }
                    , { "action": "p1" }
                    , { "action": "right" }
                    , { "action": "p1" }
                    , { "action": "right" }
                    , { "action": "p1" }
                    , { "action": "bulb" }
                    ]
          , "p1": [ { "action": "forward" }, { "action": "forward" } ]
          }
}


level_3_2 = { "board":
  [ [ {}
    , { "elev": 4, "goal": true }
    , {}
    , { "elev": 4, "goal": true }
    , {}
    , { "elev": 4, "goal": true }
    , {}
    ]
  , [ { "elev": 2 }
    , { "elev": 4 }
    , { "elev": 2, "goal": true }
    , { "elev": 4 }
    , { "elev": 2, "goal": true }
    , { "elev": 4 }
    , { "elev": 2, "goal": true }
    ]
  , [ {}, { "lift": true }, {}, { "lift": true }, {}, { "lift": true }, {} ]
  ]
, "bot": { "x": 0, "y": 2, "dir": 1 }
, "prog": { "main": [ { "action": "p1" }
                    , { "action": "left" }
                    , { "action": "p1" }
                    , { "action": "left" }
                    , { "action": "p1" }
                    ]
          , "p1": [ { "action": "forward" }
                  , { "action": "left" }
                  , { "action": "bulb" }
                  , { "action": "bulb" }
                  , { "action": "forward" }
                  , { "action": "forward" }
                  , { "action": "bulb" }
                  , { "action": "p2" }
                  ]
          , "p2": [ { "action": "right" }
                  , { "action": "right" }
                  , { "action": "forward" }
                  , { "action": "left" }
                  , { "action": "jump" }
                  , { "action": "bulb" }
                  , { "action": "right" }
                  , { "action": "jump" }
                  ]
          }
}

level_6_7 = { "board":
  [ [ { "elev": 1 }
    , { "elev": 1 }
    , { "elev": 1, "color": "green" }
    , {}
    , { "color": "green" }
    , { "elev": 1 }
    , { "elev": 1, "color": "red" }
    ]
  , [ {}, {}, {}, {}, {}, {}, { "elev": 1, "color": "green" } ]
  , [ { "elev": 2, "color": "red" }
    , { "elev": 2 }
    , { "elev": 2 }
    , { "elev": 2, "color": "red" }
    , {}
    , { "elev": 2, "goal": true }
    , {}
    ]
  , [ { "elev": 2 }
    , {}
    , {}
    , { "elev": 2, "color": "green" }
    , {}
    , { "elev": 2 }
    , {}
    ]
  , [ { "elev": 2, "color": "red" }
    , { "elev": 1, "color": "green" }
    , { "elev": 1, "color": "red" }
    , { "color": "red", "elev": 3 }
    , { "color": "green", "elev": 3 }
    , { "color": "red", "elev": 2 }
    , { "color": "green" }
    ]
  , [ {}, {}, { "color": "green" }, {}, {}, {}, { "elev": 1 } ]
  , [ {}
    , {}
    , { "color": "red" }
    , { "elev": 1, "color": "green" }
    , { "elev": 1 }
    , { "elev": 1 }
    , { "elev": 1, "color": "red" }
    ]
  ]
, "bot": { "x": 0, "y": 0, "dir": 1 }
, "prog": { "main": [ { "action": "p1" } ]
          , "p1": [ { "action": "bulb" }
                  , { "action": "right", "color": "red" }
                  , { "action": "bulb", "color": "red" }
                  , { "action": "forward" }
                  , { "action": "jump", "color": "green" }
                  , { "action": "p1" }
                  ]
          }
}

rgb = (clr) ->
  { green: 0x00ff00, red: 0xff0000, teal: 0x00bbbb, yellow: 0xffff00, gray: 0xcccccc, beige: 0xf5f5dc }[clr]

rgbObj = (clr) ->
  hex = rgb clr
  r: (hex >> 16) / 255
  g: ((hex & 0xff00) >> 8) / 255
  b: (hex & 0xff) / 255

speed = 1

canvas   = document.createElement 'canvas'
renderer =
  if window.WebGLRenderingContext and canvas.getContext('webgl') and canvas.getContext('experimental-webgl')
    new THREE.WebGLRenderer antialias: true
  else
    new THREE.CanvasRenderer antialias: true

renderer.setSize window.innerWidth - 5, window.innerHeight - 5
document.body.appendChild renderer.domElement

window.camera = camera = new THREE.OrthographicCamera -1e7,
  1e7, 1e7, -1e7, -1e8, 1e7

scene = new THREE.Scene

window.updateScene = updateScene = -> renderer.render scene, camera

# global group
window.group = group = new THREE.Object3D
group.name = 'group'

# light for phong shading
window.light = light = new THREE.PointLight 0xffffff, 1.0, 0
light.position.set 500, -500, 1000
group.add light

# basic styles
flat_gray = new THREE.MeshLambertMaterial color: rgb('gray'), shading: THREE.FlatShading
beige = new THREE.MeshLambertMaterial color: rgb('beige'), shading: THREE.FlatShading
gray = new THREE.MeshLambertMaterial color: rgb('gray')
flat_blue = new THREE.MeshLambertMaterial color: 0x0000ff, shading: THREE.FlatShading
wireframe = new THREE.MeshBasicMaterial
  wireframe: true, wireframeLinewidth: 2, color: 0x666666

# "floor"
floor = new THREE.Mesh(
  new THREE.PlaneGeometry 100000, 100000
  new THREE.MeshBasicMaterial color: 0x333333
)
group.add floor

# bot model
window.bot = bot = new THREE.Object3D
bot.name = 'bot'
head_radius = 40
body_radius = 40
body_height = 150
headg = new THREE.SphereGeometry head_radius, 40
head  = new THREE.Mesh headg, new THREE.MeshLambertMaterial(color: rgb('gray'))
head.name = 'head'
head.position.y = body_height/2 + head_radius
bot.add head
bodyg = new THREE.CylinderGeometry body_radius, body_radius, body_height, 20
body  = new THREE.Mesh bodyg, gray
body.name = 'body'
bot.add body
tri = new THREE.Shape
tri.moveTo -50, -90
tri.lineTo 0, 90
tri.lineTo 50, -90
tri.lineTo -50, -90
arrow = new THREE.Mesh tri.extrude(amount: 20), flat_blue
arrow.name = 'arrow'
arrow.rotation.x = Math.PI/2
arrow.rotation.z = Math.PI
bot.add arrow
bot.rotation.x = Math.PI/2
group.add bot

# create one step of a level
tops = []
step = (x, y, height=2, color=null, lift=false) ->
  grp = new THREE.Object3D
  grp.name = 'step'

  geom = new THREE.CubeGeometry 200, 200, height
  grp.add(THREE.SceneUtils.createMultiMaterialObject geom,
    [(if lift then beige else flat_gray), wireframe])

  if lift
    pole = new THREE.Mesh new THREE.CylinderGeometry(5, 5, 400, 10), beige
    pole.rotation.x = Math.PI/2
    pole.position.z = -201
    grp.add pole
    tops[y] ?= []
    tops[y][x] = grp

  if color
    top   = new THREE.Object3D
    top.position.z = height/2+1

    geom  = new THREE.PlaneGeometry 200, 200
    mat   = new THREE.MeshBasicMaterial color: rgb(color)
    plane = new THREE.Mesh geom, mat
    tops[y] ?= []
    tops[y][x] = plane
    top.add plane

    grp.add top

  grp.position.x = x * 200
  grp.position.y = -y * 200
  grp

game = Lightbot.Game.load level_1_3

animating = 0
animateTick = ->
  return unless animating
  requestAnimationFrame animateTick
  TWEEN.update()

animations = []
animate = (obj, ms, to) ->
  animating++
  tween = new TWEEN.Tween(obj)
       .to(to, ms)
       .easing(TWEEN.Easing.Quadratic.InOut)
       .interpolation(TWEEN.Interpolation.Bezier)
       .onUpdate(updateScene)
       .onComplete(-> animating--)
  animations.push tween
  tween

botX = (x)    -> x * 200
botY = (y)    -> y * -200
botZ = (elev) -> body_height / 2 + 1 + elev * 100

moveBotTo = (x, y, jump=true) ->
  elev   = game.board[y][x].elev
  to_z   = botZ elev
  coords = x: botX(x), y: botY(y), z: [ to_z ]

  tween = animate bot.position, 1000/speed, coords
  tween.onStart ->
    from_z = bot.position.z
    coords.z[1..0] = Math.max(to_z, from_z) + 100 if to_z isnt from_z and jump

turnBotTo = (dir) ->
  #console.log 'turnBotTo', dir
  to = y: (4-dir) * Math.PI / 2
  animate(bot.rotation, 1000/speed, to).onStart ->
    cur_dir = (4 - (Math.round(bot.rotation.y / Math.PI * 2) % 4)) % 4
    if (dir - cur_dir) % 2 # if odd, i.e. 1/4 turn
      to.y = (4-dir) * Math.PI / 2
    else
      to.y = (4-dir) * Math.PI / 2

moveLiftTo = (x, y, elev) ->
  #console.log 'moveLiftTo', x, y, elev
  lift = tops[y][x]
  animate lift.position, 1000/speed, z: 1 + 100 * elev
  moveBotTo x, y, false

bulbBot = ->
  #console.log 'bulbBot'
  animate head.material.color, 250/speed, rgbObj('yellow')
  animate head.material.color, 250/speed, rgbObj('gray')

colorBot = (color) ->
  #console.log 'colorBot'
  animate body.material.color, 0, rgbObj('gray')

toggleGoal = (x, y, tagged) ->
  #console.log 'toggleGoal', x, y, tagged
  animate tops[y][x].material.color, 0,
    rgbObj(if tagged then 'yellow' else 'teal')

gameOver = (reason) ->
  animate({}, 0, {}).onStart ->
    document.getElementById('status').firstChild.nodeValue = "You #{reason}"

# stack steps
for row, y in game.board
  for square, x in row
    clr = if square.goal then 'teal' else square.color
    if square.lift
      stp = step x, y, null, clr, true
      stp.position.z = 1 + 100 * square.elev
      group.add stp
    else
      if square.elev is 0
        stp = step x, y, null, clr
        stp.position.z = 1
        group.add stp
      else
        for i in [0...square.elev]
          stp = step x, y, 100, (if i is (square.elev-1) then clr else null)
          stp.position.z = 50 + 100 * i
          group.add stp

# viewing defaults
defaults =
  position: [ -2e6, 2e6, 0 ]
  rotation: [ -7.25, 0, -0.5 ]
  scale:    [ 8200, 8200, 8200 ]

# load defaults or saved preferences
for prop, def of defaults
  pref = localStorage.getItem prop
  group[prop].fromArray(if pref then JSON.parse(pref) else def)

scene.add group

# initial bot position
bot.position.x = botX game.bot.x
bot.position.y = botY game.bot.y
bot.position.z = botZ game.board[game.bot.y][game.bot.x].elev
bot.rotation.y = (4-game.bot.dir) * Math.PI / 2

# set up draggable stuff
prev_coords = [ null, null ]
document.body.addEventListener 'mousedown', (e) ->
  prev_coords[e.button] = [ e.clientX, e.clientY ]
  renderer.domElement.style.cursor = 'move'
  e.preventDefault()

document.body.addEventListener 'mouseup', (e) ->
  prev_coords[e.button] = null
  renderer.domElement.style.cursor = 'default'
  for attr in ['rotation', 'position', 'scale']
    localStorage.setItem attr, JSON.stringify(group[attr].toArray())

document.body.addEventListener 'mousemove', (e) ->
  for prev, but in prev_coords
    continue unless prev
    dx = e.clientX - prev[0]
    dy = e.clientY - prev[1]
    if but is 0
      group.rotation.x += dy / 100
      group.rotation.z += dx / 100
    else if but is 1
      group.position.x += dx * 5000
      group.position.y -= dy * 10000
    prev_coords[but] = [ e.clientX, e.clientY ]
    updateScene()

document.getElementById('reset').addEventListener 'click', (e) ->
  for prop, def of defaults
    group[prop].fromArray def
    localStorage.removeItem prop
  updateScene()
  false

document.getElementById('stop').addEventListener 'click', (e) ->
  animating = 0
  false

window.addEventListener 'mousewheel', (e) ->
  factor = e.wheelDelta / 100
  factor = Math.abs(1/factor) if factor < 0
  group.scale.multiplyScalar factor
  updateScene()
  e.preventDefault()

# setup game event handlers
game.on 'bulbBot',        bulbBot
game.on 'botChangeColor', colorBot
game.on 'moveBot',        moveBotTo
game.on 'turnBot',        turnBotTo
game.on 'liftMove',       moveLiftTo
game.on 'toggleGoal',     toggleGoal
game.on 'gameOver',       gameOver
game.tick() while not game.over()

# start animations
setTimeout (->
  cur = first = animations.shift()
  for tween in animations
    cur.chain tween
    cur = tween
  first.start()
  animateTick()
), 0
