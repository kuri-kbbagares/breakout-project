require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    math.randomseed(os.time())
    
    gSprites = {
        ['background'] = love.graphics.newImage('sprites/background.png'),
        ['blocks'] = love.graphics.newImage('sprites/blocks.png'),
        ['hearts'] = love.graphics.newImage('sprites/hearts.png')
    }
    
    gFrames = {
        ['paddles'] = GenerateQuadsPaddles(gTextures['main']),

    }
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false
    })
    
    gStateMachine = {
        ['start'] = function() return StartState() end,
        ['serve'] = function() return ServeState() end,
        ['menu'] = function() return MenuState() end,
        ['play'] = function() return PlayState() end,
        ['paddle-select'] = function() return PaddleSelectState() end
    }

    gFrames = {
        ['paddle'] = GenerateQuadsPaddles(gSprites['blocks'])
    }
end

function love.update()
    
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
    
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
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
