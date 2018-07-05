-- Color-Grid

--[[
Finish matrix initialization, color generation, and I'm testing out an array of points.
Currently the program won't run because of some weird missing ')' or unexpected symbol
on line 14. I'll figure it out later, but the big issue is that I'm unsure if it's some
weird subtle bug or if it's an issue with my syntax.
--]]

--[[
function love.conf(t)
	t.console = true
end
--]]

function love.load()
	love.window.setMode(800, 600)
	width = 800
	height = 600			--Dimensions of LOVE2D window.
	grid = {				--Grid object.
		local path = {},			--Grid matrix.
		local pCoord = {},		--Pixels that will outline the grid.
		local colInterval = 0, 
		local rowInterval = 0,	--Grid interval.
		local function grid:mInit(w, h)
			self.colInterval, self.rowInterval = self.interval(w, h)	--Grid interval.
			local k = 1				--Counter for pCoord inside the double loop below.
			for i = 1, w do	--This double loop initializes the matrix(path) that will be the grid.
				self.path[i] = {}		
				for j = 1, h do
					--This conditional checks to see if we've landed on a pixel that will
					--be a grid line.
					if (j%self.rowInterval) == 0 or (i%self.colInterval) == 0 then
						self.path[i][j] = 1
						self.pCoord[k] = {i, j}
						k = k + 1
					else
						self.path[i][j] = 0	--Not a grid line.
					end
				end
			end
		end,	
		local function grid:interval(w, h)	--Calculates grid line intervals.
			return math.floor(w/12), math.floor(h/12)
		end,
		local function grid:colorGen()				--Generates a random color.
			local color = {0, 0, 0}
			color[1] = math.random(0, 255)
			color[2] = math.random(0, 255)
			color[3] = math.random(0, 255)
			return color
		end,
		local function grid:draw()					--Grid object's drawing function.
			love.graphics.setColor(82, 82, 122)
			love.graphics.points(pCoord)
		end
	}
	grid.__index = grid
	graph = setmetatable({}, grid)
	graph:mInit(width, height)
end

function love.update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(230, 255, 255)
	graph:draw()
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
	end
end