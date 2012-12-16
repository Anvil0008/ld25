HC = require "hardoncollider"

function onCollision(dt, shapeA, shapeB, mtvX, mtvY)
    shapeA:move(mtv_x, mtv_y)
    shapeA.instance.x = shapeA.instance.x + mtvX
    shapeA.instance.y = shapeA.instance.y + mtvY
end

function onCollisionStop(dt, shape_a, shape_b)
end

function raycast(startX, startY, endX, endY, ignoreSet)
    local difX = endX - startX
    local difY = endY - startY
    local dist = math.sqrt(math.pow(difX, 2) + math.pow(difY, 2))
    local inc = 16
    local stepX = difX * inc / dist
    local stepY = difY * inc / dist
    local x = startX
    local y = startY
    local isFound = {}
    local found = {}

    if ignoreSet == nil then
        ignoreSet = {}
    end

    for i = 0, dist, inc do
        for _, shape in ipairs(Collider:shapesAt(x, y)) do
            if ignoreSet[shape] == nil and isFound[shape] == nil then
                isFound[shape] = 1
                table.insert(found, shape)
            end
        end
        x = x + stepX
        y = y + stepY
    end

    if (x - startX) > difX or (y - startY) > difY then
        x = endX
        y = endX
        for _, shape in ipairs(Collider:shapesAt(x, y)) do
            if ignoreSet[shape] == nil and isFound[shape] == nil then
                isFound[shape] = 1
                table.insert(found, shape)
            end
        end
    end

    return found
end

return HC