require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

MOVEMENT_OF_PADDLE = 200 

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Breakout Project')
    
    gFonts = {
      ['smallFont'] = love.graphics.newFont('font/font.ttf', 8),
      ['mediumFont'] = love.graphics.newFont('font/font.ttf', 16),
      ['largeFont'] = love.graphics.newFont('font/font.ttf', 32)
      }
    
    gSprites = {
        ['background'] = love.graphics.newImage('sprites/background.png'),
        ['blocks'] = love.graphics.newImage('sprites/blocks.png'),
        ['hearts'] = love.graphics.newImage('sprites/hearts.png'),
        ['particle'] = love.graphics.newImage('sprites/particle.png')
    }

    gFrames = {
        ['paddle'] = GenerateQuadsPaddles(gSprites['blocks']),
        ['bricks'] = GenerateQuadsBricks(gSprites['blocks']),
        ['balls'] = GenerateQuadsBalls(gSprites['blocks']),
        ['hearts'] = GenerateQuads(gSprites['hearts'], 10, 9)
        --needs update
        --['particle'] = love.graphics.newImage('graphics/particle.png')
    }

    gSounds = {
      ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
      ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
      ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
      ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
      ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
      ['no-select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
      ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
      ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
      ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
      ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
      ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
      ['high-score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
      ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),

      ['music'] = love.audio.newSource('sounds/music.wav', 'stream')
  }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false
    })

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['serve'] = function() return ServeState() end,
        ['play'] = function() return PlayState() end,
        ['victory'] = function() return VictoryState() end,
        ['game-over'] = function() return GameOverState() end,
        ['high-scores'] = function() return HighScoreState() end,
        ['enter-high-score'] = function() return EnterHighScoreState() end,
        ['paddle-select'] = function() return PaddleSelectState() end
    }
    -- Change the state here manually or remove this if other states was created
    gStateMachine:change('start', {
        highScores = loadHighScore()
    })
    
    gSounds['music']:play()
    gSounds['music']:setLooping(true)
    --?Another Table for keys being Pressed
    love.keyboard.keysPressed = {}    
end

function love.keypressed(key)
  --?sets a key into true when love.keypressed(key) is called
  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  --a function used to tell if a key is pressed by declaring it as an argument
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}

end

function love.draw()
    push:apply('start')

    local backgroundWidth = gSprites['background']:getWidth()
    local backgroundHeight = gSprites['background']:getHeight()

    love.graphics.draw(gSprites['background'], 0, 0, 0, VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))
    
    gStateMachine:render()

    push:apply('end')
end
function loadHighScore()
    love.filesystem.exists('breakout-project-main')

    -- if the file doesn't exist, initialize it with some default scores
    if not love.filesystem.exists('breakout-project-main.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'NON\n'
            scores = scores .. tostring(i * 1000) .. '\n'
        end

        love.filesystem.write('breakout-project-main.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('breakout-project-main.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores
end

function renderHealth(health)
    
    local healthX = VIRTUAL_WIDTH - 50

    for i = 1, health do
        love.graphics.draw(gSprites['hearts'], gFrames['hearts'][1], healthX, 4)
        healthX = healthX + 11
    end

        -- render missing health
    for i = 1, 3 - health do
        love.graphics.draw(gSprites['hearts'], gFrames['hearts'][2], healthX, 4)
        healthX = healthX + 11
    end

end

function toRenderScore(score)
  love.graphics.setFont(gFonts['smallFont'])
  love.graphics.print( 'SCORE: ', VIRTUAL_WIDTH - 70, 15) 
  love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 15, 30, 'right')
end
