-- Color-Grid

--[[
Finally got the grid to display on the window, which means all the math and syntax work perfectly.
There are three things that I want to move onto now:
	1. Fixing grid-line interval to change depending on window dimensions.
	2. Allowing the grid-line colors and intensity to change dynamically. (Random/Trig)
	3. Considering whether path object is necessary or not.
--]]

--[[
function love.conf(t)
	t.console = true
end
--]]

function love.load()
	love.window.setMode(800, 600)
	width = 800
	height = 600					
	grid = {					-- Grid object.
		path = {},				-- Grid matrix.
		pCoord = {},			-- Pixels that will outline the grid.
		colInterval = 0, 
		rowInterval = 0,		-- Grid interval.
	}
	
	-- This function initializes the matrix(path) that will be the grid.
	function grid:mInit(w, h)
		self.colInterval, self.rowInterval = grid:interval(w, h)	
		local k = 1		-- Counter for pCoord inside the double loop below.
		for i = 1, w do	
			self.path[i] = {}		
			for j = 1, h do
				-- This conditional checks to see if we've landed on a pixel that will
				-- be a grid line.
				if (j%self.rowInterval) == 0 or (i%self.colInterval) == 0 then
					self.path[i][j] = 1
					self.pCoord[k] = {i, j}
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
	
	--Generates a random color.
	function grid:colorGen()				
		local color = {0, 0, 0}
		color[1] = math.random(0, 255)
		color[2] = math.random(0, 255)
		color[3] = math.random(0, 255)
		return color
	end
	
	--Grid object's drawing function.
	function grid:draw()					
		love.graphics.setColor(82, 82, 122)
		love.graphics.points(self.pCoord)
	end
	
	grid.__index = grid
	graph = setmetatable({}, grid)
	graph:mInit(width, height)
	
	test = 0
end

function love.update(dt)
end

function love.draw()
	graph:draw()
end