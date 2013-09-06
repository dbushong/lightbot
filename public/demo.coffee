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

rgb = (clr) ->
  { green: 0x00ff00, red: 0xff0000, teal: 0x00bbbb, yellow: 0xffff00, gray: 0xcccccc, beige: 0xf5f5dc }[clr]

renderer = new THREE.WebGLRenderer antialias: true
#renderer = new THREE.CanvasRenderer antialias: true
renderer.setSize( window.innerWidth, window.innerHeight )
document.body.appendChild( renderer.domElement )

camera = new THREE.PerspectiveCamera 75,
  window.innerWidth / window.innerHeight, 1, 5000

camera.position.z = 1500

scene = new THREE.Scene

updateScene = -> renderer.render scene, camera

# light for phong shading
light = new THREE.PointLight 0xffffff, 1.0, 0
light.position.set 300, -100, 700
scene.add light

# global group
window.group = group = new THREE.Object3D
group.name = 'group'

# basic styles
flat_gray = new THREE.MeshLambertMaterial color: rgb('gray'), shading: THREE.FlatShading
beige = new THREE.MeshLambertMaterial color: rgb('beige'), shading: THREE.FlatShading
gray = new THREE.MeshLambertMaterial color: rgb('gray')
flat_blue = new THREE.MeshLambertMaterial color: 0x0000ff, shading: THREE.FlatShading
wireframe = new THREE.MeshBasicMaterial
  wireframe: true, wireframeLinewidth: 2, color: 0x666666

# bot model
bot = new THREE.Object3D
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

game = Lightbot.Game.load level_3_2

animating = 0
animateTick = ->
  return unless animating
  requestAnimationFrame animateTick
  TWEEN.update()

animate = (obj, ms, to) ->
  animating++
  new TWEEN.Tween(obj)
       .to(to, ms)
       .easing(TWEEN.Easing.Quadratic.InOut)
       .interpolation(TWEEN.Interpolation.Bezier)
       .onUpdate(updateScene)
       .onComplete(-> animating--)
       .start()
  animateTick() if animating is 1

moveBotTo = (x, y, jump=true) ->
  coords = x: x * 200, y: y * -200
  elev   = game.board[y][x].elev
  to_z   = body_height / 2 + 1 + elev * 100
  from_z = bot.position.z

  if to_z isnt from_z # if jumping
    coords.z = if jump then [ Math.max(to_z, from_z) + 100, to_z ] else to_z

  animate bot.position, 1000, coords

turnBotTo = (dir) ->
  # TODO: don't do stupid turns
  #cur_dir = Math.round(bot.rotation.y / Math.PI * 2)
  #0 -> 1  -pi/2
  #1 -> 2  
  animate bot.rotation, 1000, y: (4-dir) * Math.PI / 2

moveLiftTo = (x, y, elev) ->
  lift = tops[y][x]
  animate lift.position, 1000, z: 1 + 100 * elev
  moveBotTo x, y, false

bulbBot = ->
  hcolor = head.material.color
  hcolor.setHex rgb('yellow')
  updateScene()
  setTimeout (-> hcolor.setHex rgb('gray') ; updateScene()), 500

toggleGoal = (x, y, tagged) ->
  tops[y][x].material.color.setHex rgb(if tagged then 'yellow' else 'teal')
  updateScene()

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

# nice angle to view
group.rotation.x = Number(localStorage.getItem('x_rot') ? -7.6)
group.rotation.y = Number(localStorage.getItem('y_rot') ? 0)

scene.add group

# initial bot position
moveBotTo game.bot.x, game.bot.y
turnBotTo game.bot.dir

# set up draggable stuff
drag_start = null
start_rot  = [group.rotation.x, group.rotation.y]
document.body.addEventListener 'mousedown', (e) ->
  drag_start = [ e.clientX, e.clientY ] if e.button is 0

document.body.addEventListener 'mouseup', ->
  drag_start = null
  start_rot  = [ group.rotation.x, group.rotation.y ]
  localStorage.setItem 'x_rot', group.rotation.x
  localStorage.setItem 'y_rot', group.rotation.y

coords = document.getElementById('coords').firstChild
document.body.addEventListener 'mousemove', (e) ->
  return unless drag_start

  dx = e.clientX - drag_start[0]
  dy = e.clientY - drag_start[1]
  group.rotation.x = start_rot[0] + dy / 100
  group.rotation.y = start_rot[1] + dx / 100
  updateScene()

document.getElementById('reset').addEventListener 'click', (e) ->
  group.rotation.x = group.rotation.y = 0
  localStorage.removeItem 'x_rot'
  localStorage.removeItem 'y_rot'
  updateScene()
  false

# setup game event handlers
game.on 'bulbBot',    bulbBot
game.on 'moveBot',    moveBotTo
game.on 'turnBot',    turnBotTo
game.on 'liftMove',   moveLiftTo
game.on 'toggleGoal', toggleGoal
game.on 'gameOver',   (reason) -> coords.nodeValue = "You #{reason}"
setInterval (-> game.tick()), 1500
