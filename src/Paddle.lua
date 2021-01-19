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

function Paddle:update(dt)
  --keyboard controls
  if love.keyboard.isDown('left') then
    self.dx = -MOVEMENT_OF_PADDLE
  elseif love.keyboard.isDown('right') then
    self.dx = MOVEMENT_OF_PADDLE
  else
    self.dx = 0 
  end
  
  if self.dx < 0 then
    self.x = math.max(0, self.x + self.dx * dt)
  else
    self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
  end
end

function Paddle:render()
    love.graphics.draw(gSprites['blocks'], gFrames['paddle'], self.x, self.y)
end
