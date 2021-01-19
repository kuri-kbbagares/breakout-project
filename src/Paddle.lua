Paddle = Class{}

function Paddle:init(skin)
    self.x = VIRTUAL_WIDTH / 2 - 32

    self.y = VIRTUAL_HEIGHT - 32

    self.dx = 0

    self.width = 64
    self.height = 16

    self.skin = skin

    self.size = 2
end

function Paddle:render()
    love.graphics.draw(gSprites['blocks'], gFrames['paddle'], self.x, self.y)
end