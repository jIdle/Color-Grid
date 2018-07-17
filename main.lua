-- Color-Grid

--[[
There are three things that I want to move onto now:
	1. Fixing grid-line interval to change depending on window dimensions.
	2. Allowing the grid-line colors and intensity to change dynamically. (Random/Trig)
	3. Considering whether path object is necessary or not.
		3a. Path object will likely be necessary as it will act as a map for color changes
			along the grid lines. (e.g. follow the 1's in order down each grid line).
			
	Guy on discord let me know that love.graphics.setPointSize() only applies to points drawn after
	its use. This means that I can call love.graphics.setPointSize() before the individual points that
	I want to alter, render/draw them, then call love.graphics.setPointSize() again and render/draw the
	rest of them. This way it will look like the points are different sizes.
--]]

--[[
function love.conf(t)
	t.console = true
end
--]]

function love.load()
	love.window.setMode(800, 600)
	love.graphics.setPointSize(3)
	local width = 800
	local height = 600	
	dTime = 0
	grid = {					-- Grid object.
		path = {},				-- Grid matrix.
		pCoord = {},			-- Pixels that will outline the grid.
		colInterval = 0, 
		rowInterval = 0,		-- Grid interval.
	}
	
	-- This function initializes the matrix(path) that will be the grid.
	function grid:mInit(w, h)
		self.colInterval, self.rowInterval = self:interval(w, h)	
		local k = 1		-- Counter for pCoord inside the double loop below.
		for i = 1, w do	
			self.path[i] = {}		
			for j = 1, h do
				-- This conditional checks to see if we've landed on a pixel that will
				-- be a grid line.
				if (j%self.rowInterval) == 0 or (i%self.colInterval) == 0 then
					self.path[i][j] = 1
					self.pCoord[k] = {i, j, 1, 1, 1}
					k = k + 1
				else
					self.path[i][j] = 0	-- Not a grid line.
				end
			end
		end
	end
	
	--Calculates grid line intervals.
	function grid:interval(w, h)			
		return math.floor(w/12), math.floor(h/12)
	end
	
	--Grid object's drawing function.
	function grid:draw()			
		love.graphics.points(self.pCoord)
	end
	
	function shapeDraw(x, y)
		love.graphics.setColor(255, 255, 255)
		love.graphics.ellipse("fill", x, y, 5, 5, 50)
	end
	
	--Calculates the closet gridline, mainly based off of the column and row intervals.
	function grid:closest(x, y)
		xPivot = self.colInterval/2
		yPivot = self.rowInterval/2
		xMod = x%self.colInterval
		yMod = y%self.rowInterval
		xDiff = math.abs(xMod - xPivot)
		yDiff = math.abs(yMod - yPivot)
		nearToGridline = math.max(xDiff, yDiff)
		
		if nearToGridline == xDiff then
			if xMod <= xPivot then
				return multipleRound(x, self.colInterval, "down"), y
			else
				return multipleRound(x, self.colInterval, "up"), y
			end
		else
			if yMod <= yPivot then
				return x, multipleRound(y, self.rowInterval, "down")
			else
				return x, multipleRound(y, self.rowInterval, "up")
			end
		end
	end
	
	--Rounds the specified number to the nearest multiple of a specified number.
	function multipleRound(toRound, multiple, direction)
		if direction == "down" then
			return toRound - (toRound%multiple)
		end
		if direction == "up" then
			return toRound + (multiple - (toRound%multiple))
		end
	end
	
	grid.__index = grid
	graph = setmetatable({}, grid)
	graph:mInit(width, height)
end

function love.update(dt)
	--dTime = dTime + dt
	--if dTime > .1 then
		for i = 1, #graph.pCoord do
			graph.pCoord[i][3] = love.math.random(0, 1)	
			graph.pCoord[i][4] = love.math.random(0, 1)	
			graph.pCoord[i][5] = love.math.random(0, 1)
		end
		--dTime = 0
	--end
end

function love.draw()
	graph:draw()
	if love.mouse.isDown(1) then
		x, y = love.mouse.getPosition()
		startX, startY = graph:closest(x, y)
		shapeDraw(startX, startY)
	end
	
end