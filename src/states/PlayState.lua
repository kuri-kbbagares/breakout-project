PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.ball = params.ball
    self.health = params.health

    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

end

function PlayState:update(dt)

    
end

function PlayState:render()
   for k, brick in pairs(self.bricks) do
       brick:render()
   end

   self.paddle:render()
   self.ball:render()

   renderHealth(self.health)
end