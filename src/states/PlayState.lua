PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bricks = LevelMaker.createMap()
end

function PlayState:update(dt)

    
end

function PlayState:render()
   for k, brick in pairs(self.bricks) do
       brick:render()
   end
end