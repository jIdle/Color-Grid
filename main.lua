-- Color-Grid

--[[
Finally got the grid to display on the window, which means all the math and syntax work perfectly.
There are three things that I want to move onto now:
	1. Fixing grid-line interval to change depending on window dimensions.
	2. Allowing the grid-line colors and intensity to change dynamically. (Random/Trig)
	3. Considering whether path object is necessary or not.
		3a. Path object will likely be necessary as it will act as a map for color changes
			along the grid lines. (e.g. follow the 1's in order down each grid line).
	
UPDATE: 	
	1. Changing the points in pCoord all at once by using love.graphics.setColor was a bad choice.
		love.graphics.setColor modifies the color of the points by some multiplier rather than a
		flat adjustment. I failed to realize that the "point" object that love defines also has a
		color parameter in the form of: 
			
			point = {x, y, r, g, b, a}
		
		This means that instead of changing the color of every point at once, I can change each
		point individually / as needed. 
	2. I also discovered that the size of the points can be changed through the use of
		love.graphics.setPointSize(). Which means I can remove the code that triples the number of
		points in pCoord and instead, simply raise the point size.
	3. Lastly, I removed colorGen() because it was changing color of points in an inneficient way.
--]]

--[[
function love.conf(t)
	t.console = true
end
--]]

function love.load()
	love.window.setMode(800, 600)
	love.graphics.setPointSize(3)
	width = 800
	height = 600	
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
				if (j%self.rowInterval) == 0 then
					self.path[i][j] = 1
					self.pCoord[k] = {i, j, 1, 1, 1}
					k = k + 1
				elseif (i%self.colInterval) == 0 then
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
	
	grid.__index = grid
	graph = setmetatable({}, grid)
	graph:mInit(width, height)
end

function love.update(dt)
	for i = 1, #graph.pCoord do
		graph.pCoord[i][3] = love.math.random(0, 1)	-- this tests points color changes individually, rather than colorGen's method.
		graph.pCoord[i][4] = love.math.random(0, 1)
		graph.pCoord[i][5] = love.math.random(0, 1)
	end
end

function love.draw()
	graph:draw()
end