Ball = Class{}

function Ball:init(skin)
    self.width = 8
    self.height = 8

    self.dy = 0
    self.dx = 0

    self.skin = skin
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 -2
    self.y = VIRTUAL_HEIGHT / 2 - 2
end

function Ball:render()
    -- gTexture is our global texture for all blocks
    -- gBallFrames is a table of quads mapping to each individual ball skin in the texture
    love.graphics.draw(gSprites['blocks'], gFrames['balls'][self.skin],
        self.x, self.y)
end