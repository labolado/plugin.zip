
--[[
	This sample will demonstrate the various uses of the Zip plugin. It will:
		1) Download three image files to the temporary directory.
		2) Zip the files.
		3) Delete downloaded files.
		4) List the contents of the zip file.
		5) Unzip the files.
--]]

local json = require("json")
local lfs = require("lfs")
local network = require("network")
local widget = require("widget")

local zip = require("plugin.zip")

local function printEvent(event) 
	print('------------------')
	print(json.prettify(event))
end

local statuses = {
		{ 1, 0, 0 },
		{ 0, 1, 0 },
	}

local function setStatus( statusText, state )
	statusText:setFillColor( unpack( statuses[state and 1 or 2 ] ) )
end


local password = nil
local startButton, doUnzip1, doZip, doList, doUnzip2, doDisplay

local centerX = display.contentCenterX
local startY = 50
local stepY = 20

local statusList = display.newText( "List", centerX, startY + stepY * 1 )
local statusUnzip1 = display.newText( "Unzip", centerX, startY + stepY * 2 )
local statusZip = display.newText( "Zip", centerX, startY + stepY * 3 )
local statusUnzip2 = display.newText( "Unzip 2", centerX, startY + stepY * 4 )
local statusDisplay = display.newText( "Display", centerX, startY + stepY * 5 )
local resultImage = display.newRect( centerX, startY + stepY * 8, 100, 100 )
resultImage.anchorY = 0
resultImage.alpha = 0

local function cleanFiles( skipArchive)
	local root = system.pathForFile( "", system.TemporaryDirectory )
	for file in lfs.dir( root ) do
		if ( file ~= "." and file ~= ".." ) then
			if skipArchive and file ~= "archive.zip" then
				os.remove(root .. '/' .. file)
			end
		end
	end
end

local function bootstrap(event)
	Runtime:removeEventListener( "key", bootstrap )
	startButton:removeSelf()
	startButton = nil 
	cleanFiles( )

	doList()
end

startButton = widget.newButton( {
	label = "Start Zipping!",
	x = centerX,
	y = startY + stepY * 6.5,
	width = 200,
	height = 40,
	textOnly = true,
	onEvent = bootstrap,
} )


Runtime:addEventListener( "key", bootstrap )


function doList()
	zip.list( {
		zipFile = "archive.zip",
		zipBaseDir = system.ResourceDirectory,
		listener = function( event )
			printEvent(event)
			setStatus(statusList, event.isError)
			if event.isError then return end
			doUnzip1()
		end
	} )
end

function doUnzip1(files)
	zip.uncompress( {
		zipFile = "archive.zip",
		zipBaseDir = system.ResourceDirectory,
		dstBaseDir = system.TemporaryDirectory,
		password = "password",
		files = files,
		listener = function( event )
			printEvent(event)
			setStatus(statusUnzip1, event.isError)
			if event.isError then return end
			doZip(event.response)
		end
	} )
end

function doZip(files)
	zip.compress( {
		zipFile = "archive.zip",
		zipBaseDir = system.TemporaryDirectory,
		srcBaseDir = system.TemporaryDirectory,
		password = password,
		srcFiles = files,
		listener = function( event )
			printEvent(event)
			setStatus(statusZip, event.isError)
			if event.isError then return end
			cleanFiles(true)
			doUnzip2({files[1]})
		end
	} )
end

function doUnzip2(files)
	zip.uncompress( {
		zipFile = "archive.zip",
		zipBaseDir = system.TemporaryDirectory,
		dstBaseDir = system.TemporaryDirectory,
		password = password,
		files = files,
		listener = function( event )
			printEvent(event)
			setStatus(statusUnzip2, event.isError)
			if event.isError then return end
			doDisplay(files[1])
		end
	} )
end

function doDisplay(file)
	resultImage.fill = { type="image", filename=file, baseDir=system.TemporaryDirectory }
	resultImage.alpha = 1
	setStatus(statusDisplay, false)
end


