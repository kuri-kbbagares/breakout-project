require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false
    })
    
    gSprites = {
        ['background'] = love.graphics.newImage('sprites/background.png'),
        ['blocks'] = love.graphics.newImage('sprites/blocks.png'),
        ['hearts'] = love.graphics.newImage('sprites/hearts.png')
    }

    gStateMachine = {
        ['menu'] = function() return MenuState() end,
        ['play'] = function() return PlayState() end
    }

    gFrames = {
        ['paddle'] = GenerateQuadsPaddles(gSprites['blocks'])
    }
end

function love.update()

end



function love.draw()
    push:apply('start')

    local backgroundWidth = gSprites['background']:getWidth()
    local backgroundHeight = gSprites['background']:getHeight()

    love.graphics.draw(gSprites['background'], 0, 0, 0, VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))

    love.graphics.draw(gSprites['blocks'], gFrames['paddle'], VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 10)
    
    push:apply('end')
end