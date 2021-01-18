require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Breakout Project')
    
    gSprites = {
        ['background'] = love.graphics.newImage('sprites/background.png'),
        ['blocks'] = love.graphics.newImage('sprites/blocks.png'),
        ['hearts'] = love.graphics.newImage('sprites/hearts.png')
    }

    gFrames = {
        ['paddle'] = GenerateQuadsPaddles(gSprites['blocks']),
        ['bricks'] = GenerateQuadsBricks(gSprites['blocks']),
        ['balls'] = GenerateQuadsBalls(gSprites['blocks']),
        ['hearts'] = GenerateQuads(gSprites['hearts'], 10, 9)
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false
    })

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end
    }
    -- Change the state here manually or remove this if other states was created
    gStateMachine:change('play', {
        paddle = Paddle(),
        bricks = LevelMaker.createMap(),
        health = 3,
        ball = Ball(1)
    })

end

function love.update()
    gStateMachine:update()

end

function love.draw()
    push:apply('start')

    local backgroundWidth = gSprites['background']:getWidth()
    local backgroundHeight = gSprites['background']:getHeight()

    love.graphics.draw(gSprites['background'], 0, 0, 0, VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))
    
    gStateMachine:render()

    push:apply('end')
end

function renderHealth(health)
    
    local healthX = VIRTUAL_WIDTH - 50

    for i = 1, health do
        love.graphics.draw(gSprites['hearts'], gFrames['hearts'][1], healthX, 4)
        healthX = healthX + 11
    end

end