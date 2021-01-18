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
    -- Change the state here manually
    gStateMachine:change('play')

end

function love.update()
    gStateMachine:update()

end

function love.draw()
    push:apply('start')

    local backgroundWidth = gSprites['background']:getWidth()
    local backgroundHeight = gSprites['background']:getHeight()

    love.graphics.draw(gSprites['background'], 0, 0, 0, VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))

    love.graphics.draw(gSprites['blocks'], gFrames['paddle'], VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 10)
    
    gStateMachine:render()

    push:apply('end')
end
