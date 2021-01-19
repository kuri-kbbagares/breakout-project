Brick = Class{}

paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
}

function Brick:init(x, y)
    -- used for coloring and score calculation
    self.tier = 0
    self.color = 1
    
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16
    
    -- used to determine whether this brick should be rendered
    self.inPlay = true
    
    self.psystem = love.graphics.newParticleSystem(gSprites['particle'], 64)

    self.psystem:setParticleLifetime(0.5, 1)

    self.psystem:setLinearAcceleration(-15, 0, 15, 80)

    self.psystem:setAreaSpread('normal', 10, 10)
    
end

function Brick:hit()
    self.psystem:setColors(
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        55 * (self.tier + 1),
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        0
    )
    self.psystem:emit(64)
    
    --update the sounds
    --gSounds['brick-hit-2']:stop()
    --gSounds['brick-hit-2']:play()


    if self.tier > 0 then
        if self.color == 1 then
            self.tier = self.tier - 1
            self.color = 4
        else
            self.color = self.color - 1
        end
    else

        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end

    if not self.inPlay then
        --update the sounds
        --gSounds['brick-hit-1']:stop()
        --gSounds['brick-hit-1']:play()
    end
end

function Brick:update(dt)
    self.psystem:update(dt)
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gSprites['blocks'], 
            gFrames['bricks'][self.color],
            self.x, self.y)
    end
end

function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end
