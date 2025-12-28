Timer = require("libraries.timer")
Class = require("libraries.class")
local Player = require("player")
_G.player = Player(1, 1, 100, 10, 400, 300)

function love.load()
    love.window.setTitle("Rougelite")
end
function love.update(dt)
    -- Updating vars
    player.dash_timer  = player.dash_timer + dt

    -- Movement
    if love.keyboard.isDown("up") then
        player:move("up", player.speed)
        player.direction = ("up")
    end
    if love.keyboard.isDown("down") then
        player:move("down", player.speed)
        player.direction = ("down")
    end
    if love.keyboard.isDown("left") then
        player:move("left", player.speed)
        player.direction = ("left")
    end
    if love.keyboard.isDown("right") then
        player:move("right", player.speed)
        player.direction = ("right")
    end


    -- Sprinting
    if love.keyboard.isDown("lshift") and player.stamina > 0 and player.is_moving == true then
        player.regen_timer =  0
        player.speed = player.base_speed + 1
        player.stamina = player.stamina - dt * player.decay
        player.is_moving = false
    else
        player.speed = player.base_speed
        player.regen_timer = player.regen_timer + dt

        if player.regen_timer >= player.regen_delay then
            player.stamina = player.stamina + dt * player.regen_rate
            if player.stamina > player.max_stamina then
                player.stamina = player.max_stamina
            end
        end
    end
    -- Dashing
    if love.keyboard.isDown('e') and player.stamina >= 20 and player.dash_timer >= player.dash_cooldown then
        player:move(player.direction, 100)
        player.stamina = player.stamina - 20
        player.dash_timer = 0
        if player.stamina <= 0 then
            player.stamina = 0
        end
    end
end

function love.draw()
    love.graphics.print(string.format("Stamina: %d", player.stamina))
    love.graphics.draw(player.img, player.x, player.y, player.rotation, player.size, player.size)
end

