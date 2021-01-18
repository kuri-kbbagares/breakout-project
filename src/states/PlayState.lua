PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bricks = LevelMaker.createMap()

    self.ball = Ball(1)

    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42
end

function PlayState:update(dt)

    
end

function PlayState:render()
   for k, brick in pairs(self.bricks) do
       brick:render()
   end

   self.ball:render()
end