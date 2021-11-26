debug = true

player = { x = 200, y = 710, speed = 150, img = nil}
canShoot = true
canShootTimerMax = 0.5
canShootTimer = canShootTimerMax

-- standard bullets
bulletImg = nil
bullets = {}

-- quants - quantum bullets
quantImg = nil
quants = {}

-- enemies
createEnemyTimerMax = 1
createEnemyTimer = createEnemyTimerMax
enemyIimg = nil
enemies = {}

-- status
isAlive = true -- are you still there
score = 0 -- how many enemies were shot

-- function for loading assets
function love.load(arg)
  player.img = love.graphics.newImage('assets/plane.png')
  bulletImg = love.graphics.newImage('assets/bullet.png')
  quantImg = love.graphics.newImage('assets/blue_beam.png')
  enemyImg = love.graphics.newImage('assets/enemy.png')
end

-- main functionality
function love.update(dt)
  canShootTimer = canShootTimer - (1 * dt)
  if canShootTimer < 0 then
    canShoot = true
  end

  if love.keyboard.isDown('escape') then
    love.event.push('quit')
  end

  if love.keyboard.isDown('left', 'a') then
    if player.x > 0 then
      player.x = player.x - (player.speed*dt)
    end
  elseif love.keyboard.isDown('right', 'd') then
    if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
      player.x = player.x + (player.speed*dt)
    end
  end

  -- new bullets
  if isAlive and love.keyboard.isDown('space', 'rctrl', 'lctrl') and canShoot then
    newBullet = { x = player.x + (player.img:getWidth()/2), y = player.y, img = bulletImg }
    table.insert(bullets, newBullet)
    canShoot = false
    canShootTimer = canShootTimerMax
  end

  for i, bullet in ipairs(bullets) do
    bullet.y = bullet.y - (250*dt)
    if bullet.y < 0 then
      table.remove(bullets, i)
    end
  end

  -- shoot quantum EPR beams
  if isAlive and love.keyboard.isDown('x') and canShoot then
    newQuant = { x = player.x, y = player.y, img = quantImg }
    table.insert(quants, newQuant)
    canShoot = false
    canShootTimer = canShootTimerMax
  end

  -- measure quantum EPR pairs to get classical bullets
  if isAlive and love.keyboard.isDown('m') then
    for i, quant in ipairs(quants) do
      -- if both qubits are measures 1 - add two new bullets
      if math.random() > 0.5 then
          newBulletA = { 
            x = quant.x + (quant.img:getWidth()), 
            y = quant.y, img = bulletImg
          }
          newBulletB = { 
            x = quant.x, 
            y = quant.y, img = bulletImg
          }
          table.insert(bullets, newBulletA)
          table.insert(bullets, newBulletB)
      end
      table.remove(quants,i)
    end
  end

  for i, quant in ipairs(quants) do
    quant.y = quant.y - (250*dt)
    if quant.y < 0 then
      table.remove(quants, i)
    end
  end
  
  createEnemyTimer = createEnemyTimer - (1 * dt)
  if createEnemyTimer < 0 then
    createEnemyTimer = createEnemyTimerMax
	  randomNumber = math.random(10, love.graphics.getWidth() - 10)
	  newEnemy = { x = randomNumber, y = -10, img = enemyImg }
	  table.insert(enemies, newEnemy)
  end

  for i, enemy in ipairs(enemies) do
  	enemy.y = enemy.y + (200 * dt)
  
  	if enemy.y > 850 then -- remove enemies when they pass off the screen
  		table.remove(enemies, i)
  	end
  end

  for i, enemy in ipairs(enemies) do
    for j, bullet in ipairs(bullets) do
      if CheckCollision(enemy.x, enemy.y, 
        enemy.img:getWidth(), enemy.img:getHeight(), 
        bullet.x, bullet.y, 
        bullet.img:getWidth(), bullet.img:getHeight()) then
        table.remove(bullets, j)
        table.remove(enemies, i)
        score = score + 1
      end
    end

    if CheckCollision(enemy.x, enemy.y, 
      enemy.img:getWidth(), enemy.img:getHeight(), 
      player.x, player.y, 
      player.img:getWidth(), player.img:getHeight()) 
      and isAlive then
        table.remove(enemies, i)
        isAlive = false
    end
  end
  
  if not isAlive and love.keyboard.isDown('r') then
	  -- remove all our bullets and enemies from screen
	  bullets = {}
	  enemies = {}

	  -- reset timers
	  canShootTimer = canShootTimerMax
	  createEnemyTimer = createEnemyTimerMax

	  -- move player back to default position
	  player.x = 50
	  player.y = 710

	  -- reset our game state
	  score = 0
	  isAlive = true
end


end

function love.draw(dt)

  -- update score information 
  if isAlive then
	  love.graphics.draw(player.img, player.x, player.y)
	  love.graphics.print("Your score: " .. score,
      20, 10)
  else
	  love.graphics.print("Press 'R' to restart",
      love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
	  love.graphics.print("Final score: " .. score,
      love.graphics:getWidth()/2-40, love.graphics:getHeight()/2+10)
  end
  
  -- draw bullets
  for i, bullet in ipairs(bullets) do
    love.graphics.draw(bullet.img, bullet.x, bullet.y)
  end

  -- draw quants
  for i, quant in ipairs(quants) do
    love.graphics.draw(quant.img, quant.x, quant.y)
  end

  -- draw enemies
  for i, enemy in ipairs(enemies) do
  	love.graphics.draw(enemy.img, enemy.x, enemy.y)
  end

end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
