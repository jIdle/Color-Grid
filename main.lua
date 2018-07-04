-- Color-Grid

--Right now you're trying to make the 2D array / matrix that holds the
--"data" for whether or not the grid is shown on certain coordinates on
--the LOVE2D window that will be shown. I'm thinking I should only worry
--about using 1's and 0's. This way all the matrix is doing is telling
--whatever other function is using to "turn off" or "turn on" the grid
--color on that coordinate. From here, the way I'm imagining that I'll
--have the color expand is by having some function check the matrix to
--see whether the adjacent cells contain zeroes or ones. If a 1 is found
--then the function can signal that and color can expand there.

--ISSUE: As it stands, I'm unsure of whether the window's coordinates
--are integers or doubles. In the inner most loop below, whether or not
--path[i][j] is marked as a 1 depends on whether i OR j is divisible by
--12 (or whatever number I choose to divide the grid into). If getDimensions()
--returned doubles, then I'll have to use a floor() function, otherwise 
--I can just check for i/j being multiples of 12.

function love.conf(t)
	t.console = true
end

function love.load()
	width, height = love.graphics.getDimensions()
	columns = width/12
	rows = height/12
	grid = {
		path = {}
		for i = 1, width do
			path[i] = {}
			for j = 1, height do
				 
			end
		end
	}
end

function love.update(dt)
end

function love.draw()
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
	end
end