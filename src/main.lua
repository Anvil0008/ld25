World = require "world"
control = require "control"
HC = require 'collision'

function love.load()
    Collider = HC(100, on_collision, collision_stop)

    love.graphics.setBackgroundColor(89, 29, 71)

    tileset = love.graphics.newImage("art/tiles.png")
    tileset:setFilter("nearest", "linear")

    world = World.new(math.ceil(math.random() * 123456789))
    control = Control.new(world)
end

function love.update(dt)
    control:moveCheck(dt)
    Collider:update(dt)
end

function love.draw()
    world:render()
end

function love.mousepressed(x, y, button)
    control:onClick(x, y, button)
end
