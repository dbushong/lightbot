levels={"level-1-1":{ "board":
  [ [ {}, {}, {} ]
  , [ {}, {}, { "goal": true } ]
  , [ {}, {}, {} ]
  ]
, "bot": { "x": 0, "y": 1, "dir": 1 }
, "prog": { "main": [ { "action": "forward" }
                    , { "action": "forward" }
                    , { "action": "bulb" }
                    ]
          }
}
,"level-1-3":{ "board":
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
,"level-2-2":{ "board":
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
,"level-3-2":{ "board":
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
,"level-3-7":{ "board":
  [ [ {}
    , { "lift": true }
    , { "elev": 4 }
    , { "elev": 4 }
    , { "elev": 4 }
    , { "elev": 4 }
    ]
  , [ {}, {}, {}, {}, {}, { "elev": 3 } ]
  , [ { "elev": 2, "warp": [0,4] }
    , { "elev": 2 }
    , { "elev": 4, "lift": true }
    , { "elev": 4 }
    , { "elev": 2, "lift": true }
    , { "elev": 3 }
    ]
  , [ {}, {}, {}, {}, {}, {} ]
  , [ { "elev": 2, "warp": [0,2] }
    , { "elev": 2, "warp": [3,4] }
    , {}
    , { "elev": 2, "warp": [1,4] }
    , { "elev": 2, "lift": true }
    , { "elev": 4, "goal": true }
    ]
  ]
, "bot": { "x": 0, "y": 0, "dir": 1 }
, "prog": { "main": [ { "action": "forward" }
                    , { "action": "bulb" }
                    , { "action": "p2" }
                    , { "action": "p2" }
                    , { "action": "right" }
                    , { "action": "jump" }
                    , { "action": "forward" }
                    , { "action": "right" }
                    , { "action": "jump" }
                    , { "action": "p2" }
                    , { "action": "bulb" }
                    , { "action": "p1" }
                    ]
          , "p1": [ { "action": "p2" }
                  , { "action": "bulb" }
                  , { "action": "right" }
                  , { "action": "right" }
                  , { "action": "forward" }
                  , { "action": "p2" }
                  , { "action": "p2" }
                  , { "action": "bulb" }
                  ]
          , "p2": [ { "action": "bulb" }
                  , { "action": "forward" }
                  , { "action": "forward" }
                  ]
          }
}
,"level-5-5":{ "board":
  [ [ { "elev": 2 }
    , { "elev": 2 }
    , { "elev": 2 }
    , { "elev": 2 }
    , { "elev": 2 }
    , { "elev": 1, "goal": true }
    ]
  , [ {}
    , { "goal": true }
    , { "goal": true }
    , { "goal": true }
    , { "goal": true }
    , { "color": "green" }
    ]
  ]
, "bot": { "x": 0, "y": 1, "dir": 1 }
, "prog": { "main": [ { "action": "p1" }
                    , { "action": "left" }
                    , { "action": "jump" }
                    , { "action": "bulb" }
                    ]
          , "p1": [ { "action": "forward" }
                  , { "action": "bulb" }
                  , { "action": "return", "color": "green" }
                  , { "action": "p1" }
                  ]
          }
}
,"level-6-4":{ "board":
  [ [ { "color": "green" }
    , { "goal": true }
    , { "goal": true }
    , { "goal": true }
    , { "goal": true }
    , { "goal": true }
    , { "color": "green" }
    ]
  , [ { "goal": true }
    , { "color": "green", "elev": 1 }
    , { "goal": true, "elev": 1 } 
    , { "goal": true, "elev": 1 } 
    , { "goal": true, "elev": 1 } 
    , { "color": "green", "elev": 1 }
    , { "goal": true }
    ]
  , [ { "goal": true }
    , { "goal": true, "elev": 1 }
    , { "color": "green", "elev": 2 }
    , { "goal": true, "elev": 2 }
    , { "color": "green", "elev": 2 }
    , { "goal": true, "elev": 1 }
    , { "goal": true }
    ]
  , [ { "goal": true }
    , { "goal": true, "elev": 1 }
    , { "goal": true, "elev": 2 }
    , { "goal": true, "elev": 3 }
    , { "goal": true, "elev": 2 }
    , { "goal": true, "elev": 1 }
    , { "goal": true }
    ]
  , [ { "goal": true }
    , { "goal": true, "elev": 1 }
    , { "goal": true, "elev": 2 }
    , { "color": "red", "elev": 2 }
    , { "color": "green", "elev": 2 }
    , { "goal": true, "elev": 1 }
    , { "goal": true }
    ]
  , [ { "goal": true }
    , { "goal": true, "elev": 1 }
    , { "color": "red", "elev": 1 } 
    , { "goal": true, "elev": 1 } 
    , { "goal": true, "elev": 1 } 
    , { "color": "green", "elev": 1 }
    , { "goal": true }
    ]
  , [ { "goal": true }
    , { "color": "red" }
    , { "goal": true }
    , { "goal": true }
    , { "goal": true }
    , { "goal": true }
    , { "color": "green" }
    ]
  ]
, "bot": { "x": 0, "y": 6, "dir": 0 }
, "prog": { "main": [ { "action": "p1" } ]
          , "p1": [ { "action": "bulb" }
                  , { "action": "forward" }
                  , { "action": "bulb" }
                  , { "action": "right", "color": "green" }
                  , { "action": "bulb", "color": "green" }
                  , { "action": "right", "color": "red" }
                  , { "action": "bulb" }
                  , { "action": "p2" }
                  ]
          , "p2": [ { "action": "jump" }
                  , { "action": "p1" }
                  ]
          }
}
,"level-6-7":{ "board":
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
};
