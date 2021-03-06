-- Library Files 
push = require 'lib/push'
Class = require 'lib/class'

-- [[ Include every files in here to make each other connected ]]

-- On "src" folder
require 'src/Ball'
require 'src/Brick'
require 'src/LevelMaker'
require 'src/Paddle'
require 'src/StateMachine'
require 'src/Util'


-- On "src/states" folder
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/ServeState'
require 'src/states/EnterHighScoreState'
require 'src/states/GameOverState'
require 'src/states/HighScoreState'
require 'src/states/PaddleSelectState'
require 'src/states/VictoryState'
