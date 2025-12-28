Class = require 'libraries.class'
Player = Class{
    init = function (self, size, base_speed, max_stamina, max_health, x, y)

        self.max_stamina = max_stamina
        self.max_health = max_health
        self.size = size
        self.rotation = 0
        self.is_moving = false
        self.x = x
        self.y = y
        self.img = love.graphics.newImage("assets/player.png")
        self.health = max_health
        self.stamina = max_stamina
        self.base_speed = base_speed
        self.speed = self.base_speed
        self.decay = 40
        self.regen_rate = 20
        self.regen_delay = 1
        self.regen_timer = 0
        -- utilities
        self.direction = 'left'
        self.dash_cooldown = 5
        self.dash_timer = 0
    end;
    move = function (self, direction, amount)
        if not amount or amount <= 0 then
            return
        end
            self.is_moving = true
        if direction == "up" then
            self.y = self.y - amount
        elseif direction == "down" then
            self.y = self.y + amount
        elseif direction == "left" then
            self.x = self.x - amount
        elseif direction == "right" then
            self.x = self.x + amount
        else
            self.is_moving = false
        end
    end
}
return Player